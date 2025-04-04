FROM python:3.11-buster AS builder
# Specify the variable you need
ARG RAILWAY_SERVICE_ID
RUN echo $RAILWAY_SERVICE_ID

RUN pip install poetry==2.1.1

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/root/.cache/pip

WORKDIR /app

COPY pyproject.toml poetry.lock README.md ./

#RUN --mount=type=cache,id=s/$RAILWAY_SERVICE_ID-$POETRY_CACHE_DIR,target=$POETRY_CACHE_DIR poetry install --without dev --no-root
#
#FROM python:3.11-slim-buster AS runtime
#
#ENV VIRTUAL_ENV=/app/.venv \
#    PATH="/app/.venv/bin:$PATH"
#
#COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
#
#COPY src/battlesnake ./src/battlesnake
#
#ENTRYPOINT ["python", "-m", "annapurna.main"]
