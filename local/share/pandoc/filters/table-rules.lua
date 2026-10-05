-- Add a horizontal rule between body rows of tables in LaTeX/PDF output.
if not FORMAT:match('latex') then return {} end

local found_table = false

function Table(tbl)
  local latex = pandoc.write(pandoc.Pandoc({tbl}), 'latex')
  local head, body = latex:match('^(.-\\endlastfoot\n)(.*)$')
  if not body then return nil end
  found_table = true
  -- Put a \midrule after every row ending, then drop the one after the last row.
  body = body:gsub(' \\\\\n', ' \\\\\n\\midrule\\noalign{}\n')
  body = body:gsub('\\midrule\\noalign{}\n(\\end{longtable})', '%1')
  return pandoc.RawBlock('latex', head .. body)
end

-- Tables are now raw LaTeX, so tell the template to still load longtable/booktabs.
function Meta(meta)
  if found_table then
    meta.tables = true
    return meta
  end
end

return {{Table = Table}, {Meta = Meta}}
