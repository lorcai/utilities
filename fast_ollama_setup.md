# 🚀 Setting up a private LLM interface in minutes

Minimal guide to quickly set up a Large Language Model (LLM) interface similar to ChatGPT on your local machine.

These are all the sites you won't have to go to because everything is going to work perfectly but if it doesn't, go to the original repositories/websites (as this is all taken from there):

**Ollama** provides an environment for running LLMs.

- [Ollama Website](https://ollama.com/)
- [Ollama Github](https://github.com/ollama/ollama)
- [Docker Hub: Ollama](https://hub.docker.com/r/ollama/ollama)

**Open-WebUI** is an open source ChatGPT-like web interface that can be used with LLMs like Llama.

- [Open WebUI Website](https://openwebui.com/)
- [Open WebUI Github](https://github.com/ollama/ollama)

This takes just a few minutes thanks to the power of open-source, docker and really clever people!

> **Note:** Obviously, you should already have docker installed.

---

## 1 Container, 1 line

You *can* get this done with a single command that [installs a just one container with Ollama and Open WebUI](https://docs.openwebui.com/#installing-open-webui-with-bundled-ollama-support)

```bash
docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
```

But I like the separate containers better, and this is also for my own keeping, so 😉

---

## 2 Containers: 1, 2, GO 🏃💨

### Pull the Ollama Docker Image
```bash
docker pull ollama/ollama
```

### Create and Run the Container for the first time
```bash
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

### Check if Ollama is Running

- Go to: [http://localhost:11434/](http://localhost:11434/)

You should see a message saying, "Ollama is running."

### Download and run the Open webUI Docker Container
```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### ⏱️ Time to test it

- Go to: [http://localhost:8080/](http://localhost:8080/)

You will have to make an account (this is stored locally so you don't even really need to input a real email).

The ollama container comes with no models. Start it up with llama3 so that it downloads it:

```bash
docker exec -it ollama ollama run llama3
```
Then just do `/bye` and go back to the browser.

---
---


### If You Encountered a Network Error

Thats no fun. If navigating to [http://localhost:8080/](http://localhost:8080/) on your browser throws a network error, try the following:

#### Delete the open-webui container
```bash
docker stop open-webui
docker rm  open-webui
```

#### Create it again with:
```bash
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

## 🤔 Other things you should know

After creating the containers with `docker run` they will be started automatically and run in the background. You can stop the containers anytime usng `docker stop` and the name we passed with `--name ollama`:

```bash
docker stop ollama
docker stop open-webui
```

And start them again with:

```bash
docker start ollama
docker start open-webui
```

Know that you can open a terminal within the Ollama container and Run Llama:

```bash
docker exec -it ollama ollama run llama3
```

If you phone is on the same network as the computer running the Open WebUI, you can access it from your phone browser:

- Go to: `http://<OpenWebUI_ip_adress>:8080`

You can also **Disable Authentication** in the Open-webUI interface by adding the following flag to the `docker run` command for open-webui:
```bash
-e WEBUI_AUTH=False
```
> **Warning:** The same chats and the Open-webUI installation settings will be accessible to everyone who can reach your host
