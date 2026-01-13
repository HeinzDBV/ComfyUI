# ComfyUI Development Guide for AI Coding Agents

## Hardware Specifications
```
GPU: NVIDIA GeForce RTX 4060 Laptop (8GB VRAM)
RAM: 32GB DDR4/DDR5
OS: Windows
```

### Model Recommendations by Use Case

**Daily Workflow (Speed Priority):**
- Use SD 1.5 models (DreamShaper 8, ReV Animated)
- Resolution: 512x768
- Time: 20-40s per image
- VRAM: 3-4GB safe

**Final Art (Quality Priority):**
- Can use SDXL with caution
- Resolution: 768x1024 (not 1024x1536)
- Time: 2-4 min per image
- VRAM: 6-8GB (at limit, may need `--lowvram`)
- Disable other GPU apps
- Consider generating at 512x768 + upscale 4x for better speed/quality

## Architecture Overview

Node-based visual AI workflow: **Nodes** (registered in `NODE_CLASS_MAPPINGS`) → **Graph Execution** (`execution.py`, async with caching) → **WebSocket** (`server.py`) → Frontend

Key files: `nodes.py` (core), `execution.py` (executor), `comfy/` (models), `comfy_api/` (V3 API), `comfy_extras/` (extra nodes), `custom_nodes/` (extensions)

## Node Development

**V3 API (Preferred)** - Use `io.ComfyNode` + `define_schema()`:
```python
from comfy_api.latest import io

class MyNode(io.ComfyNode):
    @classmethod
    def define_schema(cls):
        return io.Schema(
            node_id="UniqueId",  # Must be globally unique
            category="category/subcategory",
            inputs=[io.Image.Input("input"), io.Int.Input("steps", default=20, min=1, max=100)],
            outputs=[io.Image.Output()]
        )
    
    @classmethod
    def execute(cls, input, steps) -> io.NodeOutput:
        return io.NodeOutput(result)  # NOT tuple!
```

**V1 API (Legacy)** - Use `INPUT_TYPES` + `NODE_CLASS_MAPPINGS`:
```python
class OldNode:
    @classmethod
    def INPUT_TYPES(s):
        return {"required": {"image": ("IMAGE",), "strength": ("FLOAT", {"default": 1.0})}}
    RETURN_TYPES = ("IMAGE",)
    FUNCTION = "process"
    def process(self, image, strength):
        return (result,)  # Return tuple

NODE_CLASS_MAPPINGS = {"OldNode": OldNode}  # Register
```

**V3 Extension Registration**:
```python
# custom_nodes/your_ext/__init__.py
from comfy_api.latest import ComfyExtension
class MyExt(ComfyExtension):
    async def get_node_list(self): return [Node1, Node2]
def comfy_entrypoint(): return MyExt()
```

## Execution Model

`execution.py:PromptExecutor` → Async DAG execution with caching (only re-runs changed nodes via `fingerprint_inputs`/`IS_CHANGED`)

```python
# Async nodes for API calls
@classmethod
async def execute(cls, api_key, prompt):
    result = await api_call(api_key, prompt)
    return io.NodeOutput(result)
```

Flow: Validate → Build execution list → Execute topologically → Cache → Send via WebSocket

## Development Workflows

### Running Tests

```bash
# Unit tests (mocked, fast)
pip install -r tests-unit/requirements.txt
python -m pytest tests-unit -m "not inference"

# Integration tests (requires models)
python -m pytest tests -m execution
**Tests**: `python -m pytest tests-unit -m "not inference"` (unit), `python -m pytest tests -m execution` (integration)

**Run Server**: `python main.py` (standard), `--lowvram` (for SDXL on 8GB), `--cpu` (no GPU), `--verbose` (debug)

**Debug Workflows**: Save as JSON from UI → Inspect structure → Use `GraphBuilder` (`comfy_execution/graph_utils.py`) for code gener

# Load checkpoint (handles VAE, CLIP, UNet)
ckpt_path = folder_paths.get_full_path_or_raise("checkpoints", "model.safetensors")
model, clip, vae = load_checkpoint_guess_config(ckpt_path)
```

### ControlNet Integration

ControlNet nodes in `comfy/controlnet.py` follow pattern:
```python
# Apply control with strength and timestep range
control_net.set_cond_hint(control_image, strength, (start_percent, end_percent))
```

### Frontend Integration

Custom nodes can add web UI components:
```python
# In your custom node module
WEB_DIRECTORY = "./js"  # Relative to module

# Or use pyproject.toml:
[tool.comfy]
web = "web"
```

JavaScript extensions placed in `WEB_DIRECTORY` auto-load in frontend.

### Internationalization (i18n)

CusKey Patterns

**Model Loading**: `folder_paths.get_full_path_or_raise("checkpoints", "file")` → `load_checkpoint_guess_config(path)` → returns `(model, clip, vae)`

**ControlNet**: `control_net.set_cond_hint(image, strength, (start_%, end_%))` (see `comfy/controlnet.py`)

**Memory**: Always use `comfy.model_management.get_torch_device()` + `tensor.to(device)`, wrap operations in `with comfy.model_management.load_models_gpu([model]):`

**Frontend**: Set `WEB_DIRECTORY = "./js"` in node module or `[tool.comfy] web = "web"` in pyproject.toml

**i18n**: Place translations in `custom_nodes/your_node/locales/{lang}/main.json`
- Async functions when I/O-bound (API calls, file ops)
- No `print()` statements (use `logging.info/warning/error`)

Run linter:
```bash
pip install ruff
ruff check .
```

## File Organization

- `nodes.py` → 2400+ lines, contains core nodes (consider refactoring new nodes to `comfy_extras/`)
- `comfy_extras/` → Domain-specific nodes (audio, video, samplers, etc.)
- `comfy_api_nodes/` → Cloud API integrations (Stability AI, Replicate, etc.)
- Tests mirror source structure: `tests-unit/app_test/` → `app/`

## Database & Migrations

ComfyUI uses Alembic for database migrations (`alembic_db/`):
```bash
# Generate migration
alembic revision --autogenerate -m "description"

# Apply migrations
alembic upgrade head
```

## Feature Flags

Check `comfy_api/feature_flags.py` before using experimental features:
```python
from comfy_api import feature_flags
if feature_flags.is_enabled("new_feature"):
    # Use new behavior
```

## Additional Resources

- Node Examples: `comfy_extras/` (many V3 nodes demonstrating patterns)
- API Nodes: `comfy_api_nodes/` (external API integration patterns)
- Teritical Gotchas

1. **Node IDs**: Must be globally unique (V3 `node_id` or V1 `NODE_CLASS_MAPPINGS` keys) - duplicates silently overwrite
2. **Returns**: V3 = `io.NodeOutput(val1, val2)`, V1 = `(val1, val2)` tuple
3. **Memory on 8GB VRAM**: For SDXL, use `--lowvram`, close browsers/other GPU apps, consider 512x768→upscale instead of 1024x1536
4. **Execution Blocking**: `return io.NodeOutput(ExecutionBlocker("reason"))` for conditional flow
5. **Logging**: Use `logging.info/warning/error`, never `print() & Organization

- Ruff linter enforced (`ruff check .`), type hints required, async for I/O
- New nodes → `comfy_extras/` (not `nodes.py` - 2400+ lines already)
- API integrations → `comfy_api_nodes/`
- Tests mirror structure: `tests-unit/app_test/` ↔ `app/`

## Quick Reference

**Migrations**: `alembic revision --autogenerate -m "desc"` → `alembic upgrade head`

**Feature Flags**: Check `comfy_api/feature_flags.is_enabled("feature")` before experimental code

**Execution Context**: `from comfy_execution.utils import CurrentNodeContext` → `CurrentNodeContext.get_node_id()`

**Examples**: Browse `comfy_extras/` for V3 node patterns, `comfy_api_nodes/` for API integrations

**Workflows**: https://comfyanonymous.github.io/ComfyUI_examples/