# ============================================================
# SeqLengthPlot v2.0 (Shiny App in R)
# ============================================================
# Equivalent to the Python CLI tool:
#   SeqLengthPlot v2.0, an all-in-one, easy-to-use Python-based tool.
#   This Shiny app replicates that functionality with an interactive UI.
# Citation: Dany Domínguez-Pérez et al., Bioinformatics Advances, 2025
# DOI: https://doi.org/10.1093/bioadv/vbae183

# -------------------------
# LOAD REQUIRED LIBRARIES
# -------------------------
library(shiny)
library(seqinr)
library(ggplot2)
library(rmarkdown)
library(tools)

# -------------------------
# USER INTERFACE (UI)
# -------------------------
ui <- fluidPage(
  titlePanel("SeqLengthPlot - Shiny App (R Version)"),
  
  helpText("📊 SeqLengthPlot v2.0 is an interactive application to explore and analyze sequence length distributions from FASTA files."),
  helpText("🧪 Upload DNA or protein sequences, define a cutoff, and split the file into two parts (above and below the cutoff)."),
  helpText("📈 Visualizations include histograms (linear/log scale), customizable by color, and exportable as PNG, PDF, SVG."),
  helpText("📄 The app also generates a statistical summary and downloadable split FASTA files."),
  helpText("🔗 Learn more: https://doi.org/10.1093/bioadv/vbae183"),
  helpText("🧪 Example file: DeTox_output_Ss_SE_candidate_toxins.fasta (included for demo use)"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("fasta_file", "Upload FASTA File", accept = c(".fa", ".fasta")),
      numericInput("cutoff", "Length Cutoff", value = 200, min = 0),
      radioButtons("seqtype", "Sequence Type", choices = c("DNA", "Protein"), selected = "DNA"),
      checkboxInput("logscale", "Log Scale Plot", value = FALSE),
      selectInput("plotColor", "Plot Color", choices = c("skyblue", "blue", "green", "purple", "orange"), selected = "skyblue"),
      checkboxGroupInput("plotFormats", "Include Formats in Plot ZIP", choices = c("PNG", "PDF", "SVG"), selected = c("PNG", "PDF")),
      actionButton("analyze", "Analyze"),
      br(),
      
      downloadButton("downloadExample", "Download Example FASTA"),
      helpText("📥 Download a sample FASTA file to test the app."),
      downloadButton("downloadStats", "Download Stats (.txt)"),
      downloadButton("downloadAbove", "Download >= Cutoff FASTA"),
      downloadButton("downloadBelow", "Download < Cutoff FASTA"),
      downloadButton("downloadPlot", "Download Current Plot (.png)"),
      downloadButton("downloadPlotSet", "Download Split Plot Set (.zip)")
    ),
    
    mainPanel(
      h3("Sequence Length Distribution"),
      plotOutput("lengthPlot"),
      h3("Summary Statistics"),
      verbatimTextOutput("summaryStats"),
      br(),
      helpText("🛠 Trouble uploading your FASTA file? If your file is very large, or you experience long processing times due to internet speed, you might prefer using the Python or R version of this app locally."),
      helpText("📦 Please check the code for the Python CLI or the R Shiny version on GitHub: https://github.com/danydguezperez/SeqLengthPlot"),
      helpText("💬 Contact: [LinkedIn](https://www.linkedin.com/in/dany-dominguez-perez/) or [X (Twitter)](https://x.com/danydguezperez)")
    )
  )
)

# -------------------------
# SERVER LOGIC
# -------------------------
server <- function(input, output, session) {
  # Allow download of example FASTA file
  output$downloadExample <- downloadHandler(
    filename = function() {
      "DeTox_output_Ss_SE_candidate_toxins.fasta"
    },
    content = function(file) {
      file.copy("DeTox_output_Ss_SE_candidate_toxins.fasta", file)
    }
  )
  
  # Parse uploaded FASTA file
  fasta_data <- eventReactive(input$analyze, {
    req(input$fasta_file)
    seq_type <- if (input$seqtype == "Protein") "AA" else "DNA"
    seqs <- read.fasta(input$fasta_file$datapath, seqtype = seq_type)
    lengths <- sapply(seqs, length)
    list(lengths = lengths, sequences = seqs, seq_type = input$seqtype)
  })
  
  # Determine unit label (aa or nt)
  unit_label <- reactive({ if (input$seqtype == "Protein") "aa" else "nt" })
  
  # Build main histogram
  plot_obj <- reactive({
    dat <- fasta_data()
    df <- data.frame(Length = dat$lengths)
    label_cut <- if (input$logscale) "Log-Scale Distribution" else "Seq Length Distribution"
    label_range <- if (input$cutoff > 0) {
      if (input$logscale) paste("Above", input$cutoff - 1, unit_label())
      else paste("Below", input$cutoff, unit_label())
    } else {
      paste0("(", unit_label(), ")")
    }
    
    p <- ggplot(df, aes(x = Length)) +
      geom_histogram(bins = 50, fill = input$plotColor, color = "black", alpha = 0.7) +
      labs(
        x = "Sequence Length",
        y = ifelse(input$logscale, "Log Frequency", "Frequency"),
        title = paste(label_cut, label_range)
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
    
    if (input$cutoff > 0) {
      p <- p + geom_vline(xintercept = input$cutoff, color = "red", linetype = "dashed", linewidth = 1)
    }
    if (input$logscale) {
      p <- p + scale_y_log10()
    }
    p
  })
  
  output$lengthPlot <- renderPlot({ plot_obj() })
  
  output$summaryStats <- renderPrint({
    dat <- fasta_data()
    lengths <- dat$lengths
    cutoff <- input$cutoff
    above <- lengths[lengths >= cutoff]
    below <- lengths[lengths < cutoff]
    cat("Total sequences:", length(lengths), "\n")
    cat("Sequences >=", cutoff, ":", length(above), ", Min:", ifelse(length(above) > 0, min(above), "N/A"), ", Max:", ifelse(length(above) > 0, max(above), "N/A"), "\n")
    cat("Sequences <", cutoff, ":", length(below), ", Min:", ifelse(length(below) > 0, min(below), "N/A"), ", Max:", ifelse(length(below) > 0, max(below), "N/A"), "\n")
  })
  
  output$downloadStats <- downloadHandler(
    filename = function() {
      paste0("seq_length_stats_by_cutoff_", input$cutoff, ".txt")
    },
    content = function(file) {
      dat <- fasta_data()
      lengths <- dat$lengths
      cutoff <- input$cutoff
      above <- lengths[lengths >= cutoff]
      below <- lengths[lengths < cutoff]
      con <- file(file, open = "wt")
      writeLines(sprintf("Total Sequences = %d", length(lengths)), con)
      writeLines(sprintf("Above %d: %d | Min = %s | Max = %s", cutoff - 1, length(above), ifelse(length(above) > 0, min(above), "N/A"), ifelse(length(above) > 0, max(above), "N/A")), con)
      writeLines(sprintf("Below %d: %d | Min = %s | Max = %s", cutoff, length(below), ifelse(length(below) > 0, min(below), "N/A"), ifelse(length(below) > 0, max(below), "N/A")), con)
      close(con)
    }
  )
  
  output$downloadAbove <- downloadHandler(
    filename = function() {
      paste0("seq_above", input$cutoff - 1, ".fasta")
    },
    content = function(file) {
      dat <- fasta_data()
      above <- dat$sequences[which(dat$lengths >= input$cutoff)]
      write.fasta(sequences = above, names = names(above), file.out = file)
    }
  )
  
  output$downloadBelow <- downloadHandler(
    filename = function() {
      paste0("seq_below", input$cutoff, ".fasta")
    },
    content = function(file) {
      dat <- fasta_data()
      below <- dat$sequences[which(dat$lengths < input$cutoff)]
      write.fasta(sequences = below, names = names(below), file.out = file)
    }
  )
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste0("seq_length_distribution_cutoff_", input$cutoff, ifelse(input$logscale, "_log", ""), ".png")
    },
    content = function(file) {
      ggsave(file, plot = plot_obj(), width = 8, height = 5)
    }
  )
  
  output$downloadPlotSet <- downloadHandler(
    filename = function() {
      paste0("seq_length_distribution_cutoff_", input$cutoff, "_plots.zip")
    },
    content = function(file) {
      dat <- fasta_data()
      cutoff <- input$cutoff
      above <- dat$lengths[dat$lengths >= cutoff]
      below <- dat$lengths[dat$lengths < cutoff]
      temp_dir <- tempdir()
      unit <- unit_label()
      formats <- tolower(input$plotFormats)
      
      savePlot <- function(data, label, log = FALSE) {
        base <- paste0("seq_length_distribution_", label, unit, if (log) "_log" else "")
        p <- ggplot(data.frame(Length = data), aes(x = Length)) +
          geom_histogram(bins = 50, fill = input$plotColor, color = "black", alpha = 0.7) +
          labs(x = "Sequence Length", y = ifelse(log, "Log Frequency", "Frequency"), title = paste("Distribution", label, paste0("(", unit, ")"))) +
          theme_minimal() +
          theme(plot.title = element_text(hjust = 0.5))
        if (log) p <- p + scale_y_log10()
        
        if ("png" %in% formats) ggsave(file.path(temp_dir, paste0(base, ".png")), p, width = 8, height = 5)
        if ("pdf" %in% formats) ggsave(file.path(temp_dir, paste0(base, ".pdf")), p, width = 8, height = 5, device = cairo_pdf)
        if ("svg" %in% formats) ggsave(file.path(temp_dir, paste0(base, ".svg")), p, width = 8, height = 5, device = "svg")
      }
      
      savePlot(above, paste0("above", cutoff - 1))
      savePlot(below, paste0("below", cutoff))
      savePlot(above, paste0("above", cutoff - 1), log = TRUE)
      savePlot(below, paste0("below", cutoff), log = TRUE)
      
      zip(zipfile = file, files = list.files(temp_dir, pattern = "seq_length_distribution_.*", full.names = TRUE), flags = "-j")
    }
  )
}

# -------------------------
# LAUNCH APPLICATION
# -------------------------
shinyApp(ui = ui, server = server)
