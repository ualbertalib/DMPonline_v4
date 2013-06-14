require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { question_default_value: @question.question_default_value, question_dependency_id: @question.question_dependency_id, question_dependency_text: @question.question_dependency_text, question_guidance: @question.question_guidance, question_order: @question.question_order, question_parent_id: @question.question_parent_id, question_suggested_answer: @question.question_suggested_answer, question_text: @question.question_text, question_type: @question.question_type, section_id: @question.section_id }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    put :update, id: @question, question: { question_default_value: @question.question_default_value, question_dependency_id: @question.question_dependency_id, question_dependency_text: @question.question_dependency_text, question_guidance: @question.question_guidance, question_order: @question.question_order, question_parent_id: @question.question_parent_id, question_suggested_answer: @question.question_suggested_answer, question_text: @question.question_text, question_type: @question.question_type, section_id: @question.section_id }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end
end
