require 'rails_helper'

RSpec.describe "vending machine show page" do
  context "as any type of user" do
    it "should see all snacks and prices" do
      owner = Owner.create(name: "trevor")
      machine = Machine.create(location: "turing", owner: owner)
      snack = Snack.create(name: "twix", price: 1)
      snack2 = Snack.create(name: "snickers", price: 1.5)
      snack3 = Snack.create(name: "chips", price: 1.5)
      MachineSnack.create(snack: snack, machine: machine)
      MachineSnack.create(snack: snack2, machine: machine)

      visit machine_path(machine)

      within "#snack-#{snack.id}" do
        expect(page).to have_content("Snack: #{snack.name}")
        expect(page).to have_content("Price: $#{snack.price}")
      end

      within "#snack-#{snack2.id}" do
        expect(page).to have_content("Snack: #{snack2.name}")
        expect(page).to have_content("Price: $#{snack2.price}")
      end

      expect(page).to_not have_content(snack3.name)
    end
  end
end
