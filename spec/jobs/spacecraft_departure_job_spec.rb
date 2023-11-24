RSpec.describe SpacecraftDepartureJob, type: :job do
  subject(:job) { described_class.perform_later(mission) }

  let(:mission) { create(:mission, :scheduled) }

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  # TODO: Flaky test?
  #  @see https://github.com/souzagab/houston/actions/runs/6975750846/job/18983329963#step:6:158
  xit "queues the job" do
    expect { job }.to have_enqueued_job(described_class).on_queue("spacecraft_departures")
  end

  it "is in spacecraft_departures queue" do
    expect(described_class.new.queue_name).to eq("spacecraft_departures")
  end

  context "when mission is not scheduled" do
    let(:mission) { create(:mission, :started) }

    it "does not change mission status" do
      expect { perform_enqueued_jobs { job } }
        .not_to change { mission.reload.status }
    end
  end

  context "when mission is scheduled" do
    it "changes mission status to started" do
      expect { perform_enqueued_jobs { job } }
        .to change { mission.reload.status }
        .from("scheduled").to("started")
    end
  end
end
