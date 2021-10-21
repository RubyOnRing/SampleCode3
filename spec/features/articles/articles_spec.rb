require "rails_helper"

RSpec.feature "/articles" do
  let!(:current_user) { login_as_user nil }

  context "articles" do
    let!(:articles) { FactoryBot.create_list(:article, 5, user: current_user) }
    before do
      current_user.reload
      visit articles_path
    end

    it 'correct articles title' do
      articles.each do |article|
        expect(page).to have_text(article.title)
      end
    end

    it 'display correct number of articles' do
      expect(page).to have_selector(:xpath, '//div[@id="articles"]//tbody/tr', count: articles.size)
    end
  end

  context "no article to display" do
    before do
      visit articles_path
    end

    it 'correct articles title' do
      expect(page.find("#articles .alert.alert-warning").text).to eq("No data to display")
    end
  end
end
