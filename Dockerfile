# ==============================================================================
# Build process
# ------------------------------------------------------------------------------
FROM public.ecr.aws/docker/library/python:3.12.9-alpine3.21 AS build
ENV PATH="$PATH:/app/bin/"
ENV PYTHONUSERBASE="/app"

WORKDIR /app/
COPY app /app/

# Adding dependencies
RUN pip3 install --user --no-cache-dir --prefer-binary -r requirements.txt

# ==============================================================================
# Component specific
# ------------------------------------------------------------------------------
FROM public.ecr.aws/docker/library/python:3.12.9-alpine3.21
ENV PATH="$PATH:/app/bin/"
ENV PYTHONUSERBASE="/app"
COPY --from=build /app /app

RUN addgroup --gid "998" --system "docker" && \
    adduser -S "user" -G "docker"

USER user

ENTRYPOINT ["molecule"]

WORKDIR /code/
