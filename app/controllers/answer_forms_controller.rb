class AnswerFormsController < ApplicationController
  def show
    @questions = Question.where(user_id: current_user.id)
  end
end


# def show
#   @question = Question.find(params[:question_id])
#   @answer_form = AnswerForm.new(question: @question)
# end

# def create
#   @answer_form = AnswerForm.new(answer_form_params)
#   if @answer_form.correct?
#     redirect_to root_path, notice: "正解です！"
#   else
#     redirect_to new_question_answer_form_path(@answer_form.question), alert: "不正解です！"
#   end
# end

# private

# def answer_form_params
#   params.require(:answer_form).permit(:question_id, :answer)
# end
# end
# 次に、AnswerFormモデルを作成します。AnswerFormモデルは、解答フォームで受け取った回答が正解かどうかを判定するメソッドを持ちます。以下のコードでは、AnswerFormモデルを作成し、回答が正解かどうかを判定するcorrect?メソッドを実装しています。

# ruby
# Copy code
# # app/models/answer_form.rb
# class AnswerForm
# include ActiveModel::Model

# attr_accessor :question, :answer

# validates :answer, presence: true

# def correct?
#   question.answer == answer
# end
# end
# 最後に、解答フォームのビューを作成します。以下のコードでは、問題のタイトルと内容、解答欄、そして送信ボタンが表示されます。

# erb
# Copy code
# <!-- app/views/answer_forms/show.html.erb -->
# <h1><%= @question.title %></h1>
# <p><%= @question.content %></p>

# <%= form_with model: @answer_form, url: question_answer_form_path(@question), local: true do |form| %>
# <%= form.label :answer %>
# <%= form.text_field :answer %>

# <%= form.submit "回答する" %>
# <% end %>
# 以上が、問題及び解答の作成、メール送信、回答フォーム、回答判定の実装に関するRailsフレームワークを使用したサンプルの実装となります。






