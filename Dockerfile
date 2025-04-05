FROM python:3.11-buster AS builder

RUN pip install poetry==2.1.1

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1

WORKDIR /app

COPY pyproject.toml poetry.lock README.md ./

RUN poetry install --without dev --no-root

FROM python:3.11-slim-buster AS runtime

ARG PORT

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY src/battlesnake ./src/battlesnake
