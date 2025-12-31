#!/usr/bin/env julia
#=
Happy New Year 2026 - TUI Version
Made with ❤️ by Kudra for her best friend
=#

# ═══════════════════════════════════════════════════════════════════
# Import FIGLet.jl for ASCII art text banners
# ═══════════════════════════════════════════════════════════════════

try
    using FIGlet
catch
    import Pkg
    Pkg.add("FIGlet")
    using FIGlet
end

# ═══════════════════════════════════════════════════════════════════
# ANSI Color Codes - Dark Cobalt Blue Theme
# ═══════════════════════════════════════════════════════════════════

const COBALT_DARK = "\033[38;5;17m"      # #0a0a14
const COBALT_BLUE = "\033[38;5;25m"      # #0047AB
const COBALT_LIGHT = "\033[38;5;62m"     # #4169E1
const COBALT_CYAN = "\033[38;5;39m"      # #00BFFF
const GOLD = "\033[38;5;220m"            # #ffd700
const WHITE = "\033[37m"
const GRAY = "\033[90m"
const RESET = "\033[0m"
const BOLD = "\033[1m"

# Animation codes
const CLEAR_SCREEN = "\033[2J\033[H"
const HIDE_CURSOR = "\033[?25l"
const SHOW_CURSOR = "\033[?25h"

# ═══════════════════════════════════════════════════════════════════
# Utility Functions
# ═══════════════════════════════════════════════════════════════════

function clear_screen()
    print(CLEAR_SCREEN)
    flush(stdout)
end

function hide_cursor()
    print(HIDE_CURSOR)
    flush(stdout)
end

function show_cursor()
    print(SHOW_CURSOR)
    flush(stdout)
end

function sleep_with_anim(duration::Float64)
    elapsed = 0.0
    chars = ['\\', '|', '/', '─']
    idx = 1
    while elapsed < duration
        print("\r$(chars[idx]) ")
        flush(stdout)
        sleep(0.1)
        elapsed += 0.1
        idx = mod1(idx + 1, length(chars))
    end
    print("\r  \r")
    flush(stdout)
end

# ═══════════════════════════════════════════════════════════════════
# Password Screen
# ═══════════════════════════════════════════════════════════════════

const CORRECT_PASSWORD = "2026"

function draw_lock_icon()
    println("    $(COBALT_CYAN)║$(RESET)       $(BOLD)$(GOLD)   ┌─────┐   $(RESET)                                     $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)       $(BOLD)$(GOLD)   │ 🔒  │   $(RESET)                                     $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)       $(BOLD)$(GOLD)   └─────┘   $(RESET)                                     $(COBALT_CYAN)║$(RESET)")
end

function password_screen()::Bool
    clear_screen()
    hide_cursor()
    
    println()
    println("    $(COBALT_CYAN)╔════════════════════════════════════════════╗$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                            $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)      $(BOLD)$(COBALT_LIGHT)🎆 Enter the Magic 🎆$(RESET)$(COBALT_CYAN)                 ║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                            $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)        $(GRAY)A special gift awaits you...$(RESET)$(COBALT_CYAN)        ║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                            $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)╚════════════════════════════════════════════╝$(RESET)")
    println()
    print("    $(BOLD)$(COBALT_CYAN)Enter Password ➜ $(RESET)")
    
    flush(stdout)
    
    # Read password (hidden input)
    password = ""
    
    try
        if isinteractive()
            password = Base.getpass("Password")
        else
            password = readline()
        end
    catch
        password = readline()
    end
    
    if password == CORRECT_PASSWORD
        println()
        println("    $(GOLD)✓ Access Granted! Opening your gift...$(RESET)")
        sleep(1.0)
        return true
    else
        println()
        println("    $(GOLD)✗ Wrong password! Try again.$(RESET)")
        sleep(1.5)
        return password_screen()
    end
end

# ═══════════════════════════════════════════════════════════════════
# Main Content - Animated Header
# ═══════════════════════════════════════════════════════════════════

function draw_2026()
    println()
    println("$(COBALT_DARK)╔══════════════════════════════════════════════╗$(RESET)")
    println("$(COBALT_DARK)║$(RESET)                                              $(COBALT_DARK)║$(RESET) $(COBALT_CYAN)")
    
    # Generate FIGLet ASCII art for "2026" with centered banner font
    FIGlet.render("    2026 ", "banner")
    println("$(RESET)$(COBALT_DARK)║$(RESET)                                             $(COBALT_DARK)║$(RESET)")
    println("$(COBALT_DARK)╚═════════════════════════════════════════════╝$(RESET)")
    println()
end

function typing_effect(text::String, delay::Float64=0.05)
    for char in text
        print(char)
        flush(stdout)
        sleep(delay)
    end
    println()
end

# ═══════════════════════════════════════════════════════════════════
# Wishes Section
# ═══════════════════════════════════════════════════════════════════

const wishes = [
    ("✨", "SUCCESS", "May all your dreams and goals come true in 2026!"),
    ("💫", "HAPPINESS", "Endless joy and happiness fill your days! "),
    ("❤️", "LOVE", "May your heart be filled with love and warmth!     "),
    ("🌟", "DREAMS", "All your dreams take flight in the new year!  "),
    ("💪", "HEALTH", "Strong body, sharp mind, vibrant spirit!"),
    ("🌍", "ADVENTURE", "Exciting journeys and adventures await!")
]

function draw_wish_card(icon::String, title::String, message::String, index::Int)
    # Card theme colors
    card_colors = [COBALT_BLUE, COBALT_LIGHT, COBALT_CYAN]
    color = card_colors[mod1(index, length(card_colors))]
    
    width = 56
    inner_width = width - 2
    padding = 2
    
    # Top border
    println()
    println("    $(color)┌$(repeat("─", inner_width))┐$(RESET)")
    
    # Header: Icon and Title
    # Note: Emojis typically take 2 columns in terminals
    icon_display_width = 2 
    header_text = "$(icon) $(BOLD)$(title)$(RESET)"
    header_width = icon_display_width + 1 + length(title)
    header_padding = inner_width - padding - header_width
    
    println("    $(color)│$(RESET)$(repeat(" ", padding))$(header_text)$(repeat(" ", max(0, header_padding)))$(color)│$(RESET)")
    println("    $(color)│$(RESET)$(repeat(" ", inner_width))$(color)│$(RESET)")
    
    # Message body with word wrapping
    max_text_width = inner_width - (2 * padding)
    words = split(strip(message))
    current_line = ""
    
    for word in words
        test_line = isempty(current_line) ? word : current_line * " " * word
        if length(test_line) > max_text_width
            println("    $(color)│$(RESET)$(repeat(" ", padding))$(rpad(current_line, max_text_width))$(repeat(" ", padding))$(color)│$(RESET)")
            current_line = word
        else
            current_line = test_line
        end
    end
    
    if !isempty(current_line)
        println("    $(color)│$(RESET)$(repeat(" ", padding))$(rpad(current_line, max_text_width))$(repeat(" ", padding))$(color)│$(RESET)")
    end
    
    # Bottom border
    println("    $(color)│$(RESET)$(repeat(" ", inner_width))$(color)│$(RESET)")
    println("    $(color)└$(repeat("─", inner_width))┘$(RESET)")
end

function draw_wishes()
    println()
    println("    $(GOLD)╔════════════════════════════════════════════════════════════╗$(RESET)")
    println("    $(GOLD)║$(RESET)                                                            $(GOLD)║$(RESET)")
    println("    $(GOLD)║$(RESET)             $(BOLD)$(GOLD)🎊 My Wishes for You 🎊$(RESET)                        $(GOLD)║$(RESET)")
    println("    $(GOLD)║$(RESET)                                                            $(GOLD)║$(RESET)")
    println("    $(GOLD)╚════════════════════════════════════════════════════════════╝$(RESET)")
    println()
    
    for (i, (icon, title, message)) in enumerate(wishes)
        draw_wish_card(icon, title, message, i)
        sleep(0.3)
    end
end

# ═══════════════════════════════════════════════════════════════════
# Personal Greeting
# ═══════════════════════════════════════════════════════════════════

function draw_greeting()
    println()
    println("    $(COBALT_CYAN)╔═══════════════════════════════════════════════════════════════╗$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                                               $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)       $(BOLD)$(GOLD)Dear My Best Friend,$(RESET)                                    $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                                               $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)  As we step into 2026, I want to take a moment to tell        $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)  you how grateful I am for having you in my life.             $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)  You are not just my best friend, you are my family.          $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)  Here's to another year of adventures, laughter,              $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)  and memories!                                                $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)║$(RESET)                                                               $(COBALT_CYAN)║$(RESET)")
    println("    $(COBALT_CYAN)╚═══════════════════════════════════════════════════════════════╝$(RESET)")
    println()
end

function draw_quote()
    println()
    println("    $(GOLD)══════════════════════════════════════════════════════════════════════$(RESET)")
    println()
    println("       $(WHITE)\"Best friends are the people who make your life brighter,\"$(RESET)")
    println("                        $(GOLD)— especially on the darkest days.$(RESET)")
    println()
    println("                            $(BOLD)$(GOLD)🥂 Here's to us!$(RESET)")
    println()
    println("    $(GOLD)══════════════════════════════════════════════════════════════════════$(RESET)")
    println()
end

function draw_footer()
    println()
    println("    $(COBALT_LIGHT)╔══════════════════════════════════════════════════════════════╗$(RESET)")
    println("    $(COBALT_LIGHT)║$(RESET)                                                              $(COBALT_LIGHT)║$(RESET)")
    println("    $(COBALT_LIGHT)║$(RESET)                 $(BOLD)$(COBALT_CYAN)From Kudra with ❤️$(RESET)                            $(COBALT_LIGHT)║$(RESET)")
    println("    $(COBALT_LIGHT)║$(RESET)                                                              $(COBALT_LIGHT)║$(RESET)")
    println("    $(COBALT_LIGHT)║$(RESET)                        $(BOLD)$(GOLD)2026$(RESET)                                  $(COBALT_LIGHT)║$(RESET)")
    println("    $(COBALT_LIGHT)║$(RESET)                                                              $(COBALT_LIGHT)║$(RESET)")
    println("    $(COBALT_LIGHT)╚══════════════════════════════════════════════════════════════╝$(RESET)")
    println()
end

function confetti_animation()
    println()
    println("    $(COBALT_BLUE)🎊$(RESET) $(COBALT_LIGHT)🎊$(RESET) $(COBALT_CYAN)🎊$(RESET) $(GOLD)🎊$(RESET) $(COBALT_BLUE)🎊$(RESET) $(COBALT_LIGHT)🎊$(RESET) $(COBALT_CYAN)🎊$(RESET) $(GOLD)🎊$(RESET)")
    println()
end

# ═══════════════════════════════════════════════════════════════════
# Main Program
# ═══════════════════════════════════════════════════════════════════

function main()
    # Check password first
    if !password_screen()
        clear_screen()
        show_cursor()
        println("    $(GOLD)Goodbye! 👋$(RESET)")
        return
    end
    
    # Main content
    clear_screen()
    
    # Animate header
    draw_2026()
    sleep(0.5)
    
    # Typing effect for welcome message
    println()
    print("    ")
    typing_effect("$(BOLD)$(COBALT_CYAN)Happy New Year, Best Friend! 🎆$(RESET)", 0.08)
    sleep(0.5)
    
    println("    $(GRAY)Let's make 2026 amazing together! ✨$(RESET)")
    println()
    
    # Scroll indicator
    println("    $(COBALT_CYAN)↓ Scroll for Wishes ↓$(RESET)")
    println()
    sleep(1.5)
    
    # Personal greeting
    draw_greeting()
    sleep(0.8)
    
    # Wishes
    draw_wishes()
    sleep(0.5)
    
    # Special quote
    draw_quote()
    sleep(0.5)
    
    # Footer
    draw_footer()
    
    # Final confetti
    confetti_animation()
    
    println("    $(BOLD)$(GOLD)Made with ❤️ by Kudra$(RESET)")
    println()
    
    show_cursor()
end

# Run if executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

