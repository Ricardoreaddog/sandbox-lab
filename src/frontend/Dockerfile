# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Native single-platform (linux/amd64) build so it works with the classic Docker
# builder too (DOCKER_BUILDKIT=0). The original used tonistiigi/xx cross-compilation,
# which requires BuildKit and breaks the "build in minikube's Docker" lab flow.
FROM golang:1.20.5-alpine AS builder

RUN apk add --no-cache ca-certificates git build-base

WORKDIR /src

# restore dependencies
COPY go.mod go.sum ./
RUN go mod download
COPY . .

# CGO is required by the Datadog tracer's App & API Protection (appsec) support.
ENV CGO_ENABLED=1
RUN go build -o /go/bin/frontend .

FROM alpine:3.17.0 AS release
RUN apk add --no-cache ca-certificates \
    busybox-extras net-tools bind-tools
WORKDIR /src
COPY --from=builder /go/bin/frontend /src/server
COPY ./templates ./templates
COPY ./static ./static

# Default behavior - a failure prints a stack trace for the current goroutine.
# See https://golang.org/pkg/runtime/
ENV GOTRACEBACK=single

EXPOSE 8080
ENTRYPOINT ["/src/server"]
