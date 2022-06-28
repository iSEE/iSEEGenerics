#' Generics for the panel interface]
#'
#' An overview of the generics for defining the user interface (UI) for each
#' panel as well as some recommendations on their implementation.
#' Individual generics are described in further details in the sections below.
#' 
#' @param x an instance of a Panel class.
#' @param se a \code{\link[SummarizedExperiment:colData]{colData(se)}} object
#' containing the current dataset.
#' This can be assumed to have been produced by running
#' `.refineParameters(x, se)`.
#' @param select_info a list of two lists, `single` and `multiple`,
#' each of which contains the character vectors row and column.
#' This specifies the panels available for transmitting single/multiple
#' selections on the rows or columns, see `?.multiSelectionDimension` and
#' `?.singleSelectionDimension` for more details.
#' @param field a string containing the name of a slot of `x`.
#'
#' @docType methods
#' @aliases defineInterface defineDataInterface hideInterface
#' @name interface-generics
#' @author Aaron Lun, Kevin Rue-Albrecht
NULL

#' @section Defining the parameter interface:
#' \code{defineInterface(x, se, select_info)} defines the UI for modifying all parameters for a given panel.
#'
#' Methods for this generic are expected to return a list of \code{\link{collapseBox}} elements.
#' Each parameter box can contain arbitrary numbers of additional UI elements,
#' each of which is expected to modify one slot of \code{x} upon user interaction.
#'
#' The ID of each interface element should follow the form of \code{PANEL_SLOT} where \code{PANEL} is the panel name (from \code{\link{.getEncodedName}(x)}) and \code{SLOT} is the name of the slot modified by the interface element, e.g., \code{"ReducedDimensionPlot1_Type"}.
#' Each interface element should have an equivalent observer in \code{\link{.createObservers}} unless they are hidden by \code{\link{hideInterface}} (see below).
#'
#' It is the developer's responsibility to call \code{\link{callNextMethod}} to obtain interface elements for parent classes.
#' A common strategy is to combine the output of \code{callNextMethod} with additional \code{\link{collapseBox}} elements to achieve the desired UI structure.
#' 
#' @examples 
#' showMethods("defineInterface")
#' 
#' @export
#' @describeIn interface-generics defines the UI for modifying all parameters for a given panel.
setGeneric("defineInterface", function(x, se, select_info) standardGeneric("defineInterface"))

#' @section Defining the data parameter interface:
#' \code{defineDataInterface(x, se, select_info)} defines the UI for data-related (i.e., non-aesthetic) parameters.
#' 
#' Methods for this generic are expected to return a list of UI elements for altering data-related parameters,
#' which are automatically placed inside the \dQuote{Data parameters} collapsible box.
#' Each element's ID should still follow the \code{PANEL_SLOT} pattern described above.
#'
#' This generic aims to provide a simpler alternative to specializing \code{defineInterface} for the most common use case.
#' New panels can write methods for this generic to add their own interface elements for altering the contents of the panel, without needing to reimplement other UI elements in the parent class's \code{defineInterface} method.
#' Conversely, there is no obligation to write a method for this generic if one is planning to specialize \code{defineInterface}.
#'
#' It is the developer's responsibility to call \code{\link{callNextMethod}} to obtain interface elements for parent classes.
#'
#' It is the developer's responsibility to call \code{\link{callNextMethod}} to hide the same interface elements as parent classes.
#' This is not strictly required if one wishes to expose previously hidden elements.
#' 
#' @examples
#' showMethods("defineDataInterface")
#' 
#' @export
#' @describeIn interface-generics defines the UI for data-related (i.e., non-aesthetic) parameters.
setGeneric("defineDataInterface", function(x, se, select_info) standardGeneric("defineDataInterface"))

#' @section Hiding interface elements:
#' \code{hideInterface(x, field)} determines whether certain UI elements should be hidden from the user.
#'
#' Methods for this generic are expected to return a logical scalar indicating whether the interface element corresponding to \code{field} should be hidden from the user.
#' This is useful for hiding UI elements that cannot be changed or have no effect, especially in highly specialized subclasses where some concepts in the parent class may no longer be relevant.
#' (The alternative would be to reimplement all of the parent's \code{defineInterface} method just to omit a handful of UI elements!)
#' 
#' @examples 
#' showMethods("hideInterface")
#' 
#' @export
#' @describeIn interface-generics determines whether certain UI elements should be hidden from the user.
setGeneric("hideInterface", function(x, field) standardGeneric("hideInterface"))
