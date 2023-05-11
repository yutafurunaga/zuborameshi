class Public::StepsController < ApplicationController
  
def step_params
  params.require(:step).permit(:instruction, :photo)
end

def create
  @step = Step.new(step_params)
  # 写真の関連付けと保存の処理
end

def update
  # 編集処理と写真の関連付けと保存の処理
end
end
