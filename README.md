# Packer Example with local docker based image.

Using packer one could create a single executable image that can be directly deployed to any machine.
The automation helps user in Packing your Node.js application into a single executable.

- Modify `COPY sampleapp sampleapp` to `COPY <application_path> <your_application_name>`

- Modify `WORKDIR /sampleapp` to `WORKDIR /<your_application_name>`

## Build Docker Container

Build docker image using below command.

`docker build . -t dockerexamplecontainer`

## Run Docker Container

Build docker image using below command.

`docker run -p 8080:80 -d dockerexamplecontainer`

## Build Packer Container

Use below command to build packer image.

`packer init`
`packer build .`