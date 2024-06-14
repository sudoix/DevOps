# deployment 

In Kubernetes, deployment is a higher-level resource that manages the creation and scaling of a set of pods. It provides a declarative way to define and manage the desired state of your application. A deployment ensures that the specified number of pod replicas are running at all times, and it can perform rolling updates to deploy new versions of your application. Deployments are also responsible for managing the lifecycle of pods, handling scaling events, and rolling back to previous versions if necessary.

deployment in Kubernetes, summarized in bullet points:

Manages the lifecycle of a set of pods.
Ensures the desired number of pod replicas are running.
Handles scaling events to increase or decrease the number of replicas.
Performs rolling updates to deploy new versions of the application.
Monitors the health of pods and takes actions such as restarting failed pods.
Provides the ability to roll back to a previous version if necessary.
Allows for declarative definition and management of the desired state of the application.

**Upgrade and roleback**