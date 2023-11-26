RSpec.describe "spacecrafts/missions" do
  before { authorize_origin }

  describe "GET /index" do
    context "when spacecraft does not exist" do
      it "returns :not_found" do
        get "/spacecrafts/0/missions"

        expect(response).to have_http_status(:not_found)
      end
    end

    context "when spacecraft exists" do
      let!(:spacecraft) { create(%i[space_bus ufo rocket].sample) }
      let!(:missions) { create_list(:mission, 3, spacecraft:) }

      before { create_list(:mission, 3) }

      it "returns only matching missions" do
        get "/spacecrafts/#{spacecraft.id}/missions", params: { spacecraft_id: spacecraft.id }

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body.size).to eq(missions.size)
      end
    end
  end
end
