
module "sqs" {
    source = "./modules/sqs"
    queue_name = "orders-queue"
}