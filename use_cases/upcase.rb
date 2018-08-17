require "../sheet.rb"

sheet = Sheet.new("../example_sheets/upcase/sheet.csv")

sheet.load()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.upcase()

sheet.print_debug_backup(true)
sheet.print_debug(true)

puts '----------------------------------'

sheet.load_as_array()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.upcase()

sheet.print_debug_backup(true)
sheet.print_debug(true)

puts '----------------------------------'

sheet.load_as_hash()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.upcase()

sheet.print_debug_backup(true)
sheet.print_debug(true)