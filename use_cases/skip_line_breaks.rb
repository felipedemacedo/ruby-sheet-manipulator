require "../sheet.rb"

sheet = Sheet.new("../example_sheets/remove_line_breaks/sheet.csv")

sheet.load()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.skip_line_breaks()

sheet.print_debug_backup(true)
sheet.print_debug(true)

puts '----------------------------------'

sheet.load_as_array()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.skip_line_breaks()

sheet.print_debug_backup(true)
sheet.print_debug(true)

puts '----------------------------------'

sheet.load_as_hash()

sheet.print_debug_backup(true)
sheet.print_debug(true)

sheet.skip_line_breaks()

sheet.print_debug_backup(true)
sheet.print_debug(true)