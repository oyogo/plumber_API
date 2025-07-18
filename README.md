# 🔁 Automating Workflows with GitHub Webhooks, Plumber, and Bash

This repository showcases how to automate end-to-end data or dashboard refresh workflows using GitHub webhooks, an R-based Plumber API, and Bash scripting. The goal is to enable reliable, repeatable, and low-maintenance deployment processes triggered directly from GitHub events.

---

## 🚀 Why Automate Workflows?

Automation brings consistency, reliability, and efficiency to your development and deployment processes:

* **Consistency**: Every execution follows the same steps, reducing human error and variability.
* **Built-in Validation**: Integrity checks can be embedded to catch errors early.
* **Time Efficiency**: Once set up, workflows run with minimal supervision, freeing up your time for higher-value tasks.

---

## 🏗️ Architecture Overview

The automation is composed of three main components:

1. **GitHub Webhook**: Triggers the workflow upon a push event.
2. **Plumber API**: Acts as a secure listener for webhook payloads.
3. **Bash Script**: Executes the actual data or dashboard refresh.

---

## 🔗 GitHub Webhook Setup

To connect your repository to the automation pipeline:

* Go to your GitHub repo → *Settings* → *Webhooks* → *Add webhook*
* **Payload URL**: URL of the server hosting your Plumber API
* **Content Type**: `application/json`
* **Secret**: Add a shared secret (also configured on the server for HMAC verification)

---

## 🛠️ Plumber API Logic

The Plumber API acts as the orchestrator of the automation:

* Defines an HTTP `POST` endpoint to receive GitHub payloads
* Parses the incoming JSON and extracts key details (e.g., pushed branch)
* Validates the request signature using HMAC (see next section)

---

## 🔐 Securing the Endpoint (HMAC Verification)

To ensure the payload is authentic and unaltered:

* GitHub signs each payload using SHA-256 and your shared secret
* The server recalculates the HMAC using the same secret
* If signatures match, the request is processed; otherwise, it's rejected

---

## ⚙️ Triggering the Workflow

The API triggers the bash script **only** if the push was to the `main` branch:

* Validates the branch from the payload
* Logs activity for transparency and debugging
* Keeps unwanted or irrelevant updates from triggering a refresh

---

## 🧩 Bash Script Logic

The Bash script contains the operational logic:

* Logs execution to a file for traceability
* Executes `git pull` to fetch the latest code
* Can be extended to run data ingestion, transformation, model training, or dashboard deployment

---

## 📁 Use Cases

This pattern is ideal for:

* Automatically refreshing R Shiny dashboards after a GitHub push
* Updating machine learning pipelines or data preprocessing scripts
* Low-maintenance deployment of analytical apps and reports

---

## ✅ Requirements

* A Linux server running R and Plumber
* GitHub repository with push access
* Basic knowledge of Git, Bash, and R

