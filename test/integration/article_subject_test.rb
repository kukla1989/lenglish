require "test_helper"

class ArticleSubjectTest < ActionDispatch::IntegrationTest
  
  test "root page should show subject form" do
    get root_path
    assert_select "input[value=?]", "show"
    assert_select "select"
  end
  
  test "all article should have subject" do
    get root_path
    Article.all.paginate(page: 1).each do |article|   
      assert_select "h5", "subject: " + article.subject
    end
  end  
  
  test "if article with chosen subject dont exist that massage should appear" do
    get root_path, params: {subject: "for_beginners"}
    assert_select "h3",  "unfortunatly there no one article with this subject but you can create!"
    #assert_match  "unfortunatly there no one article with this subject but you can create!", response.body
  end
  
  test "if chose  subject article will appear only with this subject" do
    get root_path, params: {subject: "nature"} 
    assert_select "h5", "subject: nature", count: 2
  end
end

 