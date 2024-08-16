# 🚀 Set Up Your Own LLM Interface Locally In Minutes!

This is a minimal guide to quickly set up your own Large Language Model (LLM) interface similar to ChatGPT on your local machine using Docker containers. In just a few minutes, you can have everything running smoothly, thanks to the power of open-source, docker and really clever people!

> **Note:** Obviously, you should already have docker installed!
>
> If not, please visit [Docker's official website](https://www.docker.com/get-started) for installation instructions.
>
> In case you don't know, **Containers** are lightweight, standalone packages that include everything needed to run a piece of software, such as code, libraries, and system dependencies. Using Docker containers ensures a consistent environment, regardless of where they're run.

---

## 1. Download and Set Up Ollama 

Ollama provides an environment for running LLMs. Follow these steps to get it up and running.

### Pull the Docker Image
```bash
docker pull ollama/ollama
```

### Create and Run the Container for the first time
```bash
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

### **More Info**
- [Docker Hub: Ollama](https://hub.docker.com/r/ollama/ollama)

---

## 2. Download and Set Up Open-WebUI

Open-WebUI is an awesome, open source ChatGPT-like web interface that can be used with LLMs like Llama. It will make use of the Ollama container which acts as a backend so make you sure you have set that up first.

### Pull and Run the Docker Container
```bash
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

### If You Encounter Network Errors
If the above command throws a network error, try the following:
```bash
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```


## 3. Test it!

### Check if Ollama is Running
After starting the container, navigate to:
- [http://localhost:11434/](http://localhost:11434/)

You should see a message saying, "Ollama is running."

### Check if Open-WebUI is Running
Open your browser and go to:
- [http://localhost:8080/](http://localhost:8080/)

It may take a few seconds to start up, but you should see the Open-WebUI interface.

You will have to make an account (this is stored locally so you don't even really need to input a real email).

---

### **More Info**
- [Open-WebUI Docs](https://docs.openwebui.com/getting-started/)
- [GitHub: Open-WebUI](https://github.com/open-webui/open-webui/tree/main)

---


And that's it, now you're ready to explore the power of LLMs locally! Enjoy! 🎉 

⚡ Open source POWEEEEEEEERRR! ⚡


---


## 🤔 Other things you should know

The following are just some comments about managing the containers and things you should know.


After creating the containers with `docker run` they will be started automatically and run in the background you can stop the Containers anytime usng `docker stop` and the name we passed with `--name ollama`:

```bash
docker stop ollama
docker stop open-webui
```

And start them again with:

```bash
docker start ollama
docker start open-webui
```

Know that you can open a terminal within the ollama container and Run Llama:

```bash
docker exec -it ollama ollama run llama3
```

You can also **Disable Authentication**

You can disable authentication in the Open-webUI interface by adding the following flag to the `docker run` command for open-webui:
```bash
-e WEBUI_AUTH=False
```
> **Warning:** The same chats and the Open-webUI installation settings will be accessible to everyone who can reach your host

