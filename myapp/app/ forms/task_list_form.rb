class TaskListForm
    include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにする
    include ActiveModel::Attributes # ActiveRecordのカラムのような属性を加えられるようにする
  
    attribute :title, :text
    attribute :label, :string
    attribute :name, :string
    attribute :status, :string
    attribute :user_id, :integer
  
    def save
      
    end
  end