## Kubernetes Probes

### Overview
- Kubernetes provides the following mechanisms to keep tracking of the health and availability of the containers inside a `Pod`:
  - **Startup probes**
    - The kubelet uses startup probes to know when a container application has started.
    - If such a probe is configured, liveness and readiness probes do not start until it succeeds, making sure those probes don't interfere with the application startup.
    - This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.
  - **Readiness probes**
    - The kubelet uses readiness probes to know when a container is ready to start accepting traffic.
    - A Pod is considered ready when all of its containers are ready.
    - One use of this signal is to control which Pods are used as backends for Services.
    - When a Pod is not ready, it is removed from Service load balancers.
  - **Liveness probes**
    - The kubelet uses liveness probes to know when to restart a container.
    - For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress.
    - Restarting a container in such a state can help to make the application more available despite bugs.
    - A common pattern for liveness probes is to use the same low-cost HTTP endpoint as for readiness probes, but with a higher failureThreshold.
    - This ensures that the pod is observed as not-ready for some period of time before it is hard killed.


### Probing Mechanisms
|         | **Exec**                                                               | **HTTP**                                                       | **TCP**                                                        |
|---------|------------------------------------------------------------------------|----------------------------------------------------------------|----------------------------------------------------------------|
| Probe   | Using the exec command for performing any command inside the container | using a http endpoint for checking the status of the container | using the tcp call to check if the port accepts traffic or not |
| Success | `0`                                                                    | `status codes => 200 - 399`                                    | `if port accepts traffic`                                      |
| Failure | `1`                                                                    | `other than status codes => 200 - 399`                         | `if port can't accept traffic`                                 |

- example for the **Exec** mechanism:
  - ```yaml
      exec:
        command:
          - mongo
          - --eval
          - "db.adminCommand('ping')"
    ```
- example for the **HTTP** mechanism:
  - ```yaml
      httpGet:
        path: /health
        port: 8080
    ```
- example for the **TCP** mechanism:
  - ```yaml
      tcpSocket:
        port: 8080
    ```
    
### Probes Parameters & Configuration
- Kubernetes provides several parameters for startup, readiness and liveness probes that can be adjusted to fine-tune the probe configuration.
- Each parameter has a default value, but specific situations in our environment may require that we use different parameter values.
- For example, a parameter default value gathered by the probe might not provide specific-enough information to understand why an application is slow starting.
- Alternatively, default values might capture and generate too much information, making it difficult to arrive at helpful conclusions.
- We can configure all the below parameters for the three kubernetes probe types:
  - `initialDelaySeconds`
    - Number of seconds after the container has started before startup, liveness or readiness probes are initiated.
    - If a startup probe is defined, liveness and readiness probe delays do not begin until the startup probe has succeeded.
    - Defaults to 0 seconds.
    - Minimum value is 0.
  - `periodSeconds`
    - How frequently (in seconds) the probe shall be executed after the initial delay.
    - Default to 10 seconds.
    - Minimum value is 1.
  - `timeoutSeconds`
    - Timeout period to mark as failure.
    - Defaults to 1 second.
    - Minimum value is 1.
  - `successThreshold`
    - Minimum consecutive successes for the probe to be considered successful after having failed.
    - Defaults to 1.
    - Must be 1 for liveness and startup Probes.
    - Minimum value is 1.
  - `failureThreshold`
    - After a probe fails `failureThreshold` times in a row, Kubernetes considers that the overall check has failed: the container is not `ready/healthy/live`.
    - For the case of a startup or liveness probe, if at least `failureThreshold` probes have failed, Kubernetes treats the container as unhealthy and triggers a restart for that specific container.
    - The kubelet honors the setting of `terminationGracePeriodSeconds` for that container.
    - For a failed readiness probe, the kubelet continues running the container that failed checks, and also continues to run more probes; because the check failed, the kubelet sets the `Ready` condition on the Pod to `false`.
  - `terminationGracePeriodSeconds`
    - configure a grace period for the kubelet to wait between triggering a shut-down of the failed container, and then forcing the container runtime to stop that container.
    - The default is to inherit the Pod-level value for `terminationGracePeriodSeconds` (30 seconds if not specified).
    - Minimum value is 1.

### Best Practices
- Check for the ideal frequency for running the probes.
- Health checks need to be lightweight to not slow down the container.
- Choose the correct `restartPolicy`.
- Use the probes only when needed.
- Keep an eye on probes regularly.