class AnswerFormsController < ApplicationController
  skip_before_action :require_login, only: [:new]
  before_action :login_with_token, only: [:new]
  before_action :require_login, only: [:new]

  def new
    # whereメソッドを実施することにより、配列で、qustionのレコードが格納される。
    @questions = Question.where(user_id: params[:user_id])
    @answer_form = AnswerForm.new
    @user = User.find_by(id: current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @correct_answers = Question.where(user_id: current_user.id)
    @answer_form = AnswerForm.new
    @questions = Question.where(user_id: params[:user_id])
    if @answer_form.correct?(user_answer_params, @correct_answers, get_question_ids)
      @got_up = GotUp.new
      @got_up.save(@user)
      redirect_to schedules_index_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_answer_params
    params.require(:answer_form).permit(:answer0, :answer1, :answer2)
  end

  def get_question_ids
    # パラメータを格納する配列を初期化
    question_ids = []

    # ループ処理でパラメータを取得
    3.times do |i|
      question_ids << params["question_id_#{i}"]
    end
    
    # このコードを実施しないと、3.times do |i|の3が返り値となってしまう
    return question_ids
  end

end