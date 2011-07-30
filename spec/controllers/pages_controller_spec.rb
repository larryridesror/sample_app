require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                            :content => "Ruby on Rails Tutorial | Home")
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end

      it "should have a sidebar with micropost counts" do
        get 'home'
        content = @user.microposts.count == 1?"micropost":"microposts"
        response.should have_selector("div.user_info>a>span.microposts",
                                      :content => content)
      end

      it "should paginate microposts" do
        50.times do
          Factory(:micropost, :user => @user)
        end
        get 'home'
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2", :content => "2")
        response.should have_selector("a", :href => "/?page=2", :content => "Next")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                            :content => "Ruby on Rails Tutorial | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                            :content => "Ruby on Rails Tutorial | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                            :content => "Ruby on Rails Tutorial | Help")
    end
  end

end
