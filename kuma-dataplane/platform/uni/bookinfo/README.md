# Book Info

## How To Run

1. Start `Kuma` Control Plane, create `Dataplanes` and generate tokens:

   ```shell
   docker-compose -f docker-compose-kuma-cp.yaml up -d
   ```

   Notice that `Kuma REST API` will be exposed on the host machine as [localhost:5681](http://localhost:5681) to support usage of `kumactl`.

2. Verify that `Dataplanes` have been created:

   ```shell
   kumactl get dataplanes

   MESH      NAME               TAGS
   default   dp-productpage-1   service=productpage version=1.0
   default   dp-details-1       service=details version=1.0
   default   dp-reviews-1       service=reviews version=1.0
   default   dp-rating-1        service=rating version=1.0
   ```

3. Verify that dataplane tokens have been generated:

   ```shell
   ls -l ../secrets/

   dp-details-1
   dp-productpage-1
   dp-rating-1
   dp-reviews-1
   ```

4. Start `productpage` service:

   ```shell
   docker-compose -f docker-compose-productpage.yaml up -d
   ```

   Notice that `Book Info` application will be exposed on the host machine as [localhost:9080](http://localhost:9080/productpage?u=normal).

5. Start `details` service:

   ```shell
   docker-compose -f docker-compose-details.yaml up -d
   ```

6. Start `reviews` service:

   ```shell
   docker-compose -f docker-compose-reviews.yaml up -d
   ```

7. Start `ratings` service:

   ```shell
   docker-compose -f docker-compose-ratings.yaml up -d
   ```

8. Verify that `mTLS` is not enabled yet:

   ```shell
   kumactl get meshes

   NAME      mTLS   CA        METRICS
   default   off    builtin   off
   ```

   Notice that `mTLS` is `off`.

9. Validate that `Book Info` application is up-and-running:

   ```shell
   open http://localhost:9080/productpage?u=normal
   ```

   Notice both details and reviews information on [the page](http://localhost:9080/productpage?u=normal).

10. Enable `mTLS`:

    ```shell
    kumactl apply -f mesh/default+mtls.mesh.yaml
    ```

    ```shell
    kumactl get meshes

    NAME      mTLS   CA        METRICS
    default   on     builtin   off
    ```

    Notice that `mTLS` is `on`.

11. Verify that traffic between `productpage` and other services is no longer allowed:

    ```shell
    open http://localhost:9080/productpage?u=normal
    ```

    2 error messages must appear on [the page](open http://localhost:9080/productpage?u=normal):

    * `Error fetching product details!`
    * `Error fetching product reviews!`

12. Enable traffic between all services:

    ```shell
    kumactl apply -f traffic-permission/tp-allow-all.yaml
    ```

13. Verify that traffic between `productpage` and other services is now allowed:

    ```shell
    open http://localhost:9080/productpage?u=normal
    ```

    Notice both details and reviews information on [the page](http://localhost:9080/productpage?u=normal).

## How To Cleanup

```shell
docker-compose -f docker-compose-ratings.yaml down
docker-compose -f docker-compose-reviews.yaml down
docker-compose -f docker-compose-details.yaml down
docker-compose -f docker-compose-productpage.yaml down
docker-compose -f docker-compose-kuma-cp.yaml down
```
