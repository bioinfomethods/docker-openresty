# MCRI Specific Build Instructions

MCRI mods:

* Added lua modules to the jammy/Dockerfile
* Customised image entrypoint to do ENV substitution

```bash
# PROJECT_DIR should be the root of the project
cd "$PROJECT_DIR"

docker buildx build --platform linux/amd64,linux/arm64 -t gitci-test.mcri.edu.au:5000/mcri/openresty:jammy -f jammy/Dockerfile .

docker push gitci-test.mcri.edu.au:5000/mcri/openresty:jammy
```
