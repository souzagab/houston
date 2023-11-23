RSpec.describe "Missions" do
  describe "GET /missions" do
    let!(:missions) { create_list(:mission, 3) }

    before { get "/missions" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body.size).to eq(missions.size) }
    # TODO: Test json parsing after add serializers
    # it { expect(response.parsed_body).to eq(missions.to_json) }
  end


  describe "GET /missions/:id" do
    let(:mission) { create(:mission) }

    before { get "/missions/#{mission.id}" }

    it { expect(response).to have_http_status(:ok) }
    # TODO: Test json parsing after add serializers
    # it { expect(response.parsed_body).to eq(mission.to_json) }
  end

  describe "POST /missions" do
    let(:planet) { create(:planet) }
    let(:spacecraft) { create(%i[rocket ufo space_bus].sample) }

    let(:params) do
      attributes_for(:mission).merge(planet_id: planet.id, spacecraft_id: spacecraft.id)
    end

    it "creates a new mission" do
      expect do
        post("/missions", params:)
      end.to change(Mission, :count).by(1)

      expect(response).to have_http_status(:created)

      # expect(response.parsed_body).to eq(Mission.last.to_json)
    end

    it "returns unprocessable entity if mission creation fails" do
      expect do
        post("/missions", params: params.merge({ planet_id: nil }))
      end.not_to change(Mission, :count)

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response.parsed_body).to eq({ "planet" => ["must exist"] })
    end
  end

  describe "PATCH /missions/:id" do
    let(:mission) { create(:mission) }
    let(:new_status) { "started" }

    it "updates an existing mission" do
      expect do
        patch "/missions/#{mission.id}", params: { status: new_status }
        mission.reload
      end.to change(mission, :status).from("scheduled").to(new_status)

      expect(response).to have_http_status(:ok)
    end

    it "returns unprocessable entity if mission update fails" do
      expect do
        patch "/missions/#{mission.id}", params: { planet_id: nil }
        mission.reload
      end.not_to change(mission, :planet_id)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body).to eq({ "planet" => ["must exist"] })
    end
  end

  describe "DELETE /missions/:id" do
    let!(:mission) { create(:mission) }

    it "deletes an existing mission" do
      expect do
        delete "/missions/#{mission.id}"
      end.to change(Mission, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
