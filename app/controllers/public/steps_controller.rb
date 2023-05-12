class Public::StepsController < ApplicationController
  
def step_params
  params.require(:step).permit(:instruction, :photo)
end

def create
  @step = Step.new(step_params)
end

def update
end
end
