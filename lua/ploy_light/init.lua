local lush = require('lush')
local hsl = lush.hsl
local colors = {
  bg_main = "#fff8f0",
  fg_main = "#222222",
  bg_dim = "#f6ece8",
  fg_dim = "#63728f",
  bg_alt = "#e7e0da",
  fg_alt = "#856f4a",

  bg_red_intense = "#ff8f88",
  bg_green_intense = "#8adf80",
  bg_yellow_intense = "#fac200",
  bg_blue_intense = "#cbcfff",
  bg_magenta_intense = "#df8fff",
  bg_cyan_intense = "#88c8ff",
  bg_red_subtle = "#ffcfbf",
  bg_green_subtle = "#afffbf",
  bg_yellow_subtle = "#fff576",
  bg_blue_subtle = "#ccdfff",
  bg_magenta_subtle = "#ffddff",
  bg_cyan_subtle = "#bfefff",

  bg_active = "#c7c0ba",
  bg_inactive = "#f9f2ef",
  cursor = "#1144ff",
  cursor_fg = "#feffff",
  bg_mode_line = "#f8cf8f",
  fg_mode_line = "#111133",
  bg_completion = "#fadacf",
  bg_hover = "#b4cfff",
  bg_hover_secondary = "#aaeccf",
  bg_hl_line = "#f9e8c0",
  bg_paren = "#afbfef",
  bg_err = "#ffdfe6",
  bg_warning = "#ffe5ba",
  bg_info = "#cff5d0",
  border = "#baafba",
  fg_intense = "#000000",
  modeline_err = "#950000",
  modeline_warning = "#6f008f",
  modeline_info = "#00409f",
  underline_err = "#ef0f1f",
  underline_warning = "#bf5f00",
  underline_info = "#02af52",

  red = "#cc3333",
  red_warmer = "#dd1100",
  red_cooler = "#c04440",
  red_faint = "#a2403f",
  green = "#217a3c",
  green_warmer = "#4a7d00",
  green_cooler = "#008058",
  green_faint = "#61756c",
  yellow = "#8a5d00",
  yellow_warmer = "#9f4a00",
  yellow_cooler = "#8f5a3a",
  yellow_faint = "#765640",
  blue = "#375cd8",
  blue_warmer = "#4250ef",
  blue_cooler = "#065fff",
  blue_faint = "#6060d0",
  magenta = "#ba35af",
  magenta_warmer = "#cf25aa",
  magenta_cooler = "#6052cf",
  magenta_faint = "#af569f",
  cyan = "#1f6fbf",
  cyan_warmer = "#3f70a0",
  cyan_cooler = "#1f77bb",
  cyan_faint = "#406f90",


  bg_added = "#ccefcf",
  bg_added_faint = "#e0f3e0",
  bg_added_refine = "#bae0c0",
  fg_added = "#005000",

  bg_changed = "#ffe5b9",
  bg_changed_faint = "#ffefc5",
  bg_changed_refine = "#ffd09f",
  fg_changed = "#553d00",

  bg_removed = "#ffd4d8",
  bg_removed_faint = "#ffe3e3",
  bg_removed_refine = "#ffc0ca",
  fg_removed = "#8f1313",

  selection = "#caeafa",
}

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    ColorColumn    { fg = colors.fg_main, bg = colors.bg_alt }, -- Columns set with 'colorcolumn'
    -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor         { bg = colors.cursor }, -- Character under the cursor
    CurSearch      { fg = colors.fg_intense, bg = colors.bg_yellow_intense }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM       { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine     { bg = colors.bg_hl_line }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory      { fg = colors.blue_warmer, gui = "bold" }, -- Directory names (and other special names in listings)
    DiffAdd        { fg = colors.fg_added, bg = colors.bg_added_faint }, -- Diff mode: Added line |diff.txt|
    DiffChange     { fg = colors.fg_changed, bg = colors.bg_changed_faint }, -- Diff mode: Changed line |diff.txt|
    DiffDelete     { fg = colors.fg_removed, bg = colors.bg_removed_faint }, -- Diff mode: Deleted line |diff.txt|
    DiffText       { fg = colors.fg_changed, bg = colors.bg_changed_refine }, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    TermCursor     { Cursor }, -- Cursor in a focused terminal
    TermCursorNC   { bg = colors.bg_blue_subtle }, -- Cursor in an unfocused terminal
    ErrorMsg       { fg = colors.fg_main, bg = colors.bg_err }, -- Error messages on the command line
    VertSplit      { fg = colors.border }, -- Column separating vertically split windows
    -- Folded         { }, -- Line used for closed folds
    -- FoldColumn     { }, -- 'foldcolumn'
    -- SignColumn     { }, -- Column where |signs| are displayed
    IncSearch      { CurSearch }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute     { fg = colors.fg_main, bg = colors.bg_red_intense }, -- |:substitute| replacement text highlighting
    LineNr         { fg = colors.fg_dim, bg = colors.bg_main, gui = "bold" }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove    { }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    -- LineNrBelow    { }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    -- CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign { fg = colors.fg_main }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen     { fg = colors.fg_intense, bg = colors.bg_paren }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg        { fg = colors.fg_main, gui = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea        { fg = colors.fg_main }, -- Area for messages and cmdline
    MsgSeparator   { fg = colors.fg_main }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg        { fg = colors.fg_main }, -- |more-prompt|
    NonText        { fg = colors.fg_alt }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal         { bg = colors.bg_main, fg = colors.fg_main }, -- Normal text
    NormalFloat    { fg = colors.fg_main, bg = colors.bg_inactive }, -- Normal text in floating windows.
    FloatBorder    { fg = colors.border }, -- Border of floating windows.
    -- FloatTitle     { }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    Pmenu          { fg = colors.fg_main, bg = colors.bg_dim }, -- Popup menu: Normal item.
    PmenuSel       { fg = colors.fg_main, bg = colors.bg_completion }, -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    PmenuSbar      { Pmenu }, -- Popup menu: Scrollbar.
    PmenuThumb     { bg = colors.bg_alt }, -- Popup menu: Thumb of the scrollbar.
    Question       { fg = colors.blue_warmer }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine   { fg = colors.fg_main }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search         { fg = colors.fg_main, bg = colors.bg_blue_intense }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    SpecialKey     { fg = colors.fg_alt }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad       { sp = colors.underline_err, gui = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap       { sp = colors.underline_info, gui = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal     { sp = colors.underline_info, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare      { sp = colors.underline_warning, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine     { fg = colors.fg_mode_line, bg = colors.bg_mode_line }, -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine        { fg = colors.fg_main, bg = colors.bg_alt }, -- Tab pages line, not active tab page label
    -- TabLineFill    { }, -- Tab pages line, where there are no labels
    TabLineSel     { fg = colors.fg_main, bg = colors.bg_main, gui = "bold" }, -- Tab pages line, active tab page label
    Title          { fg = colors.fg_main, gui = "bold" }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual         { bg = colors.selection }, -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg     { fg = colors.fg_main, bg = colors.bg_warning }, -- Warning messages
    Whitespace     { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator   { fg = colors.border }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu       { }, -- Current match in 'wildmenu' completion
    -- WinBar         { }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { fg = colors.red_faint, gui = "italic" }, -- Any comment

    Constant       { fg = colors.blue }, -- (*) Any constant
    String         { fg = colors.yellow_warmer }, --   A string constant: "this is a string"
    Character      { fg = colors.cyan_cooler }, --   A character constant: 'c', '\n'
    Number         { fg = colors.fg_main }, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier     { fg = colors.fg_main }, -- (*) Any variable name
    Function       { fg = colors.fg_main }, --   Function name (also: methods for classes)

    Statement      { fg = colors.blue_warmer, gui = "bold" }, -- (*) Any statement
    -- Conditional    { fg = colors.blue_warmer }, --   if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --   case, default, etc.
    Operator       { fg = colors.fg_main }, --   "sizeof", "+", "*", etc.
    -- Keyword        { }, --   any other keyword
    -- Exception      { }, --   try, catch, throw

    PreProc        { fg = colors.cyan_warmer }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { fg = colors.blue_cooler}, -- (*) int, long, char, etc.
    -- StorageClass   { }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special        { fg = colors.cyan }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    Delimiter      { Special }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { fg = colors.red }, -- Any erroneous construct
    Todo           { fg = colors.fg_main, bg = colors.bg_info }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            {} , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    LspCodeLens                 { fg = colors.fg_alt, bg = colors.bg_dim } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    LspInlayHint                { LspCodeLens },
    LspSignatureActiveParameter { fg = colors.yellow, bg = colors.bg_warning } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { fg = colors.red } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg = colors.yellow_warmer } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = colors.blue } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = colors.blue_faint } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               { fg = colors.green_cooler} , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    DiagnosticUnderlineError   { sp = colors.red, gui = "undercurl" } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { sp = DiagnosticWarn.fg, gui = "underline" } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { sp = DiagnosticInfo.fg, gui = "underline" } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { sp = DiagnosticHint.fg, gui = "underline" } , -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk      { sp = DiagnosticOk.fg, gui = "underline" } ,
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag

    diffAdded            { fg = colors.fg_added },
    diffRemoved          { fg = colors.fg_removed },
    diffChanged          { fg = colors.fg_changed },
    diffOldFile          { diffRemoved, gui = "italic" },
    diffNewFile          { diffAdded, gui = "italic" },
    diffFile             { fg = colors.fg_changed, gui = "bold" },
    diffLine             { fg = colors.magenta, gui = "bold" },
    diffIndexLine        { fg = colors.yellow },

    gitcommitOverflow          { WarningMsg },
    gitcommitHeader            { Title },
    gitcommitSummary           { Title },

    markdownUrl               { Special },
    markdownCode              { Type },
    markdownLinkText          { Identifier, gui = "underline" },
    markdownLinkTextDelimiter { Delimiter },

    GitSignsAdd                      { fg = colors.bg_added, bg = colors.bg_added },
    GitSignsChange                   { fg = colors.bg_changed, bg = colors.bg_changed },
    GitSignsDelete                   { fg = colors.bg_removed, bg = colors.bg_removed },
    GitSignsStagedAdd                { fg = colors.bg_added_faint, bg = colors.bg_added_faint },
    GitSignsStagedChange             { fg = colors.bg_changed_faint, bg = colors.bg_changed_faint },
    GitSignsStagedRemove             { fg = colors.bg_removed_faint, bg = colors.bg_removed_faint },

    TelescopeSelection               { fg = colors.fg_main, bg = colors.bg_completion },
    TelescopeSelectionCaret          { fg = colors.red_warmer },
    TelescopeMatching                { fg = colors.blue_cooler, gui = "bold" },
    TelescopeBorder                  { fg = colors.fg_mode_line },

    CmpItemAbbr                      { fg = colors.fg_main },
    CmpItemAbbrDeprecated            { fg = colors.fg_main, gui = "strikethrough" },
    CmpItemAbbrMatch                 { fg = colors.blue_cooler, gui = "bold" },
    CmpItemAbbrMatchFuzzy            { fg = colors.blue_faint, gui = "bold" },

    fugitiveHeader              { Statement },
    fugitiveHelpHeader          { Statement },
    fugitiveHunk                { fg = colors.fg_dim },
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
