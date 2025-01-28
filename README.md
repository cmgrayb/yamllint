# YAMLLint container for CI/CD pipelines

![Docker](https://github.com/cmgrayb/yamllint/actions/workflows/docker-publish.yml/badge.svg)
![Snyk Container](https://github.com/cmgrayb/yamllint/actions/workflows/snyk-codesecurity.yml/badge.svg)
![YAMLLint](https://github.com/cmgrayb/yamllint/actions/workflows/yamllint.yml/badge.svg)

This container is used to lint YAML files in CI/CD pipelines. It uses the [YAMLLint](https://yamllint.readthedocs.io/en/stable/) tool to lint the YAML files.

## Usage

### Production ring

```bash
docker run --rm -v $(pwd):/data ghcr.io/cmgrayb/yamllint[:latest] yamllint FILE_OR_DIRECTORY [additional options]
```

### Beta/nightly ring

```bash
docker run --rm -v $(pwd):/data ghcr.io/cmgrayb/yamllint:nightly yamllint FILE_OR_DIRECTORY [additional options]
```

### Alpha ring

```bash
docker run --rm -v $(pwd):/data ghcr.io/cmgrayb/yamllint:main yamllint FILE_OR_DIRECTORY [additional options]
```
