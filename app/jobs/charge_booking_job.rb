class ChargeBookingJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    job = Job.find(job_id)
    if job.status == "booking_charged" && (Time.now.hour - job.updated_at.hour) > 24
      charge = Stripe::Charge.create(
          amount: 1000,
          currency: 'usd',
          customer: job.user.stripe_id
      )
      if (charge["status"] == "succeeded")
        job.update(status: "booking_charged");
      end
    end
  end
end
