# CronJob

In Kubernetes, a CronJob is an object that creates Jobs on a recurring schedule. It uses the Cron format to specify the schedule for running the Jobs. CronJobs are useful for running tasks at specific intervals, such as running a backup job every night or sending a report every week. Each time a CronJob runs, it creates a new Job based on the specified schedule. The Job then runs the desired workload, such as running a containerized application or executing a script.

CronJobs are designed to be run on a regular basis, often using a cron job scheduler, such as cron

