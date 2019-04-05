require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe "relationships" do
    it {should have_many :machine_snacks}
    it {should have_many(:snacks).through :machine_snacks}
  end

  describe "instance methods" do
    it ".average_price" do
      owner = Owner.create(name: "trevor")
      machine = Machine.create(location: "turing", owner: owner)
      snack = Snack.create(name: "twix", price: 1)
      snack2 = Snack.create(name: "snickers", price: 2)
      snack3 = Snack.create(name: "chips", price: 1.5)
      MachineSnack.create(snack: snack, machine: machine)
      MachineSnack.create(snack: snack2, machine: machine)

      expect(machine.average_price).to eq(1.5)
    end

    it ".total_snacks" do
      owner = Owner.create(name: "trevor")
      machine = Machine.create(location: "turing", owner: owner)
      snack = Snack.create(name: "twix", price: 1)
      snack2 = Snack.create(name: "snickers", price: 2)
      MachineSnack.create(snack: snack, machine: machine)
      MachineSnack.create(snack: snack2, machine: machine)

      expect(machine.total_snacks).to eq(2)
    end
  end
end
