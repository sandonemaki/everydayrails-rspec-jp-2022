require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "ユーザーは新しいプロジェクトを作成する" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"
    
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    }.to change(user.projects, :count).by(1)
  end

  ## Capybaraのメソッド使用例
  #it "全種類のHTML要素を扱う" do
  #  # ページを開く
  #  visit "/fake/page"
  #  # リンクまたはボタンのラベルをクリックする
  #  click_on "A link or button label"
  #  # チェックボックスのラベルをチェックする
  #  check "A checkbox label"
  #  # チェックボックスのラベルのチェックを外す
  #  uncheck "A checkbox label"
  #  # ラジオボタンのラベルを選択する
  #  choose "A radio button label"
  #  # セレクトメニューからオプションを選択する
  #  select "An option", from: "A select menu"
  #  # ファイルアップロードのラベルでファイルを添付する
  #  attach_file "A file upload label", "/some/file/in/my/test/suite.gif"
  #  # 指定したCSS に⼀致する要素が存在することを検証する
  #  expect(page).to have_css "h2#subheading"
  #  # 指定したセレクターに⼀致する要素が存在することを検証する
  #  expect(page).to have_selector "ul li"
  #  # 現在のパスが指定されたパスであることを検証する
  #  expect(page).to have_current_path "/projects/new"
  #end
end
