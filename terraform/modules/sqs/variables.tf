variable "queue_name" {
    description = "The name of the SQS queue"
    type = string
}

variable "message_retention_seconds" {
    description = "How long, in seconds, messages are kept in the queue"
    type        = number
    default     = 345600  # 4 days
}