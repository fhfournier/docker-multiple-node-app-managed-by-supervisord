# Project Overview

This repository is designed for a simple Next.js application, which is built to have three separate repositories: one for the API, server-side rendering (SSR) and one more for client-generated rendering (CGR).

## Getting Started

This project requires Docker and Supervisor to manage the application processes. Below is a brief description of the setup based on the `Dockerfile` and `supervisord.conf`.

### Dockerfile

The `Dockerfile` is used to create a Docker image for the application. It sets up the environment and installs necessary dependencies for the Next.js application.

### supervisord.conf

The `supervisord.conf` file is used to configure Supervisor, which manages the processes for the Next.js application. It ensures that the application runs continuously and restarts in case of failures.

## Repository Structure

- **API**: Handles all backend logic and data management.
- **SSR (Server-Side Rendering)**: Renders pages on the server to enhance SEO and initial load performance.
- **CGR (Client-Generated Rendering)**: Renders pages on the client side for dynamic and interactive experiences.

## Purpose

This repository serves as a template for building and deploying a scalable Next.js application with separate concerns for API handling, server-side rendering, and client-side rendering.

## How to Use

1. Clone the repositories for API, SSR, and CGR.
2. Build and run the Docker containers using the `Dockerfile`.
3. Use Supervisor to manage and monitor the application processes.

Feel free to modify the setup according to your project's requirements. Enjoy building with Next.js!