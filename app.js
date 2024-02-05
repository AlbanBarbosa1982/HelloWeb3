import axios from "axios";
import prom from "prom-client";
import http from "http";

const register = new prom.Registry();
const apiKey = process.env.API_KEY;

const urls = [
  {
    url: "https://api.polygonscan.com/api?module=proxy&action=eth_blockNumber&apikey=",
    gaugeName: "Bortip",
    apiKey: apiKey,
  },
];

urls.forEach((item) => {
  item.gauge = new prom.Gauge({
    name: item.gaugeName,
    help: `Metric for ${item.url}`,
  });
  register.registerMetric(item.gauge);
});

// Function to update metrics for each URL
function updateMetrics() {
  urls.forEach((item) => {
    const fullUrl = item.url + item.apiKey;
    axios
      .get(fullUrl)
      .then((response) => {
        const blockNumberHex = response.data.result;
        const blockNumber = parseInt(blockNumberHex, 16);
        item.gauge.set(blockNumber);
        console.log("Fetched latest block number");
      })
      .catch((error) => {
        console.error(`Error fetching data from ${item.url}:`, error);
      });
  });
}

const interval = 60000;
setInterval(updateMetrics, interval);

const server = http.createServer((req, res) => {
  if (req.url === "/metrics") {
    res.setHeader("Content-Type", register.contentType);
    register.metrics().then((metrics) => {
      res.end(metrics);
    });
  } else {
    res.writeHead(200);
    res.end("Server Running");
  }
});

const PORT = process.env.PORT || 3000; // Use port 3000 by default, but you can specify it via the PORT environment variable

server.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on http://0.0.0.0:${PORT}`);
  updateMetrics();
  console.log(`Metrics are available on http://0.0.0.0:${PORT}/metrics`);
});
