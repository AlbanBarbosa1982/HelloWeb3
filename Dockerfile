FROM node:alpine3.17

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install any dependencies
RUN npm install

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run the app when the container launches
CMD ["npm", "start"]
