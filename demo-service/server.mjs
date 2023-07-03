import express from "express"
import cors from "cors"
import * as fs from "fs"

const port = process.env.PORT || 80;
const loadBalancerPrefix = process.env.LOADBALANCER_PREFIX || "";
const server = express();

server.use(cors())

server.get(
    `${loadBalancerPrefix}/health`,
    (req, res) => res.type("text/plain").send('OK')
)

server.get(
    `${loadBalancerPrefix}/`,
    async (req, res) => {
        const response = {};

        if (fs.existsSync("/tmp/test.txt")) {
            response.fs = "exists"
        }
        else {
            fs.writeFileSync("/tmp/test.txt", "foobar")
            response.fs = "created"
        }

        res.send(response)
    }
)

server.listen(
    port,
    () => console.log(`Server started listening on port ${port}.`)
)
