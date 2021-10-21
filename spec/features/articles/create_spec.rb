require "rails_helper"

RSpec.feature "/articles/new" do
  let!(:current_user) { login_as_user nil }

  context "valid article" do
    let!(:articles) { FactoryBot.create_list(:article, 5, user: current_user) }
    before do
      current_user.reload
      visit new_article_path

      page.find(:css, "input[name='article[title]']").set("new title")
      page.find(:css, "textarea[name='article[content]']").set("new content")
      page.find(:css, "input[type='submit']").click
    end

    it 'number of articles must increase' do
      expect(current_user.articles.size).to eq(articles.size + 1)
    end

    it 'new article must display on index page' do
      expect(page).to have_text('new title')
    end
  end

  context "invalid article" do
    let!(:articles) { FactoryBot.create_list(:article, 5, user: current_user) }
    before do
      visit new_article_path
    end

    it 'blank title' do
      page.find(:css, "textarea[name='article[content]']").set("new content")
      page.find(:css, "input[type='submit']").click

      expect(page.find(:css, "#error-messages")).to have_text("Title can't be blank")
      expect(current_user.articles.size).to eq(articles.size)
    end

    it 'blank content' do
      page.find(:css, "input[name='article[title]']").set("new title")
      page.find(:css, "input[type='submit']").click

      expect(page.find(:css, "#error-messages")).to have_text("Content can't be blank")
      expect(current_user.articles.size).to eq(articles.size)
    end
  end
end
