require 'rails_helper'

RSpec.describe "snack show page" do
  context "as any type of user" do
    it "should see some information about the snack" do
      owner = Owner.create(name: "trevor")
      owner2 = Owner.create(name: "rovert")
      machine = Machine.create(location: "turing", owner: owner)
      machine2 = Machine.create(location: "my house", owner: owner2)
      snack = Snack.create(name: "twix", price: 1)
      snack2 = Snack.create(name: "snickers", price: 1.5)
      snack3 = Snack.create(name: "chips", price: 2)
      snack4 = Snack.create(name: "salsa", price: 5)
      MachineSnack.create(snack: snack, machine: machine)
      MachineSnack.create(snack: snack2, machine: machine)
      MachineSnack.create(snack: snack, machine: machine2)
      MachineSnack.create(snack: snack3, machine: machine2)
      MachineSnack.create(snack: snack4, machine: machine2)

      visit snack_path(snack)

      expect(page).to have_content("All Machines selling #{snack.name}")

      within "#machine-#{machine.id}" do
        expect(page).to have_content("Location: #{machine.location}")
        expect(page).to have_content("Average Price: #{machine.average_price}")
        expect(page).to have_content("Number of Snacks sold: #{machine.total_snacks}")
      end

      within "#machine-#{machine2.id}" do
        expect(page).to have_content("Location: #{machine2.location}")
        expect(page).to have_content("Average Price: #{machine2.average_price}")
        expect(page).to have_content("Number of Snacks sold: #{machine2.total_snacks}")
      end
    end
  end
end
