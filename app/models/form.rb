class Form < ApplicationRecord
    enum status: { new: "new", fulfilled: "fulfilled", archived: "archived" }, _prefix: true
end
