# insta_clone

# tailwind setup

# create tailwind.config.js without node moduels

in powershell or teriminal :npx tailwindcss-cli@latest init

creat static golbally and inside that css/input.css

import @tailwind base; @tailwind components; @tailwind utilities; these three library form tailwind

And then run this command on teriminal or powershell to buid the tailwind css
npx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/output.css --watch

-- watch is used to run tailwind continious

Here's your corrected and polished version of the **Docker setup steps** with proper command syntax and grammar for use in a **Bash environment (Linux/macOS or Git Bash on Windows)**:

---

### **Docker Setup (Bash)**

1. **Download and install Docker Desktop**

   * Visit: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
   * Install and ensure Docker Desktop is running.

2. **Create a `Dockerfile`**
   Place it in the **root directory** of your project.

3. **Create a `.dockerignore` file**
   Also in the **root directory**. It helps avoid copying unnecessary files into the Docker image.

4. **Build the Docker image**

   ```bash
   docker build -t insta_clone .
   ```

   * `-t insta_clone` gives your image a name (tag)
   * `.` means "build from the current directory"

5. **Run the Docker container**

   ```bash
   docker run -p 8005:8000 --name insta_clone insta_clone
   ```

   * Maps host port `8005` to container port `8000`
   * `--name insta_clone` gives the container a name

6. **Run the container with volume mapping (for development)**

   ```bash
   docker run -p 8005:8000 --name insta_clone -v "${PWD}:/insta_clone" insta_clone
   ```

   * Mounts your current working directory (`${PWD}`) to `/insta_clone` inside the container
   * Useful for **live code changes**

7. **Run the container in the background (detached mode)**

   ```bash
   docker run -dp 8005:8000 --name insta_clone -v "${PWD}:/insta_clone" insta_clone
   ```

   * `-d` = detached (runs in the background)
   * `-p`, `--name`, and `-v` as before

---