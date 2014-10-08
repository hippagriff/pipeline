# Initial Setup
This document will serve as a basic guide to getting started with the Pipeline project

#### 1. Install dependencies
Change to your local directory using `cd`, then install the Node dependencies using `sudo npm install`. You will be required to enter your system password.

#### 2. Start the server
Use the `npm start` command to get the server running.

---

# Proxying with Node
With multiple environments to proxy to, you will need to change the targeted environment often:

#### Change the proxy target
Open `proxy_target.coffee`, then uncomment the desired `services` variable to set the targeted proxy environment.
