# == Schema Information
#
# Table name: missions
#
#  id                         :bigint           not null, primary key
#  description                :text             default(""), not null
#  duration(Duration in days) :integer          not null
#  start_date                 :datetime         not null
#  status                     :enum             default("scheduled"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  planet_id                  :bigint           not null
#  spacecraft_id              :bigint           not null
#
# Indexes
#
#  index_missions_on_planet_id      (planet_id)
#  index_missions_on_spacecraft_id  (spacecraft_id)
#  index_missions_on_status         (status)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#  fk_rails_...  (spacecraft_id => spacecrafts.id)
#
RSpec.describe Mission do
  describe "associations" do
    it { is_expected.to belong_to(:planet) }
    it { is_expected.to belong_to(:spacecraft) }
  end

  describe "attributes" do
    it { is_expected.to define_enum_for(:status).backed_by_column_of_type(:enum).with_values(described_class.statuses) }
  end

  describe "callbacks" do
    describe "#schedule_departure" do
      subject(:mission) { build(:mission, :scheduled) }

      it "enqueues a departure job" do
        expect { mission.save! }
          .to have_enqueued_job(SpacecraftDepartureJob)
          .with(mission)
          .on_queue("spacecraft_departures")
      end
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }

    describe "#ensure_status_was_scheduled" do
      context "when the status wasn't scheduled" do
        subject(:mission) { create(:mission, %i[canceled failed completed].sample) }

        before { mission.status = :started }

        it { is_expected.not_to be_valid }

        it "adds an error on status" do
          mission.valid?

          expect(mission.errors[:status]).to include("can only be changed from scheduled to started")
        end
      end

      context "when the status was scheduled" do
        subject(:mission) { create(:mission, :scheduled) }

        before { mission.status = :started }

        it { is_expected.to be_valid }
      end
    end

    describe "#ensure_status_was_scheduled_or_started" do
      context "when the status wasn't scheduled or started" do
        subject(:mission) { create(:mission, %i[failed completed].sample) }

        before { mission.status = :canceled }

        it { is_expected.not_to be_valid }

        it "adds an error on status" do
          mission.valid?

          expect(mission.errors[:status]).to include("can only be changed from scheduled or started to canceled")
        end
      end

      context "when the status was scheduled" do
        subject(:mission) { create(:mission, %i[scheduled started].sample) }

        before { mission.status = :canceled }

        it { is_expected.to be_valid }
      end
    end

    describe "#ensure_status_was_started" do
      context "when the status wasn't started" do
        subject(:mission) { create(:mission, %i[canceled completed].sample) }

        before { mission.status = :failed }

        it { is_expected.not_to be_valid }

        it "adds an error on status" do
          mission.valid?

          expect(mission.errors[:status]).to include("can only be changed from started to failed")
        end
      end

      context "when the status was started" do
        subject(:mission) { create(:mission, :started) }

        before { mission.status = :failed }

        it { is_expected.to be_valid }
      end
    end
  end
end
