#' Generics for the panel interface
#'
#' An overview of the generics for defining the user interface (UI) for each
#' panel as well as some recommendations on their implementation.
#' Individual generics are described in further details in the sections below.
#' 
#' @param x an instance of a Panel class.
#' @param se a [SummarizedExperiment-class] object
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
#' @author Aaron Lun, Kevin Rue-Albrecht
#' @name interface-generics
#' @aliases
#' defineInterface
#' defineDataInterface
#' hideInterface
NULL

#' @section Defining the parameter interface:
#' `defineInterface(x, se, select_info)` defines the UI for modifying all
#' parameters for a given panel.
#'
#' Methods for this generic are expected to return a list of [iSEEwidgets::collapseBox()]
#' elements.
#' Each parameter box can contain arbitrary numbers of additional UI elements,
#' each of which is expected to modify one slot of `x` upon user interaction.
#'
#' The ID of each interface element should follow the form of `PANEL_SLOT` where
#' `PANEL` is the panel name (from `.getEncodedName()` and `SLOT` is the name
#' of the slot modified by the interface element, e.g.,
#' `"ReducedDimensionPlot1_Type"`.
#' Each interface element should have an equivalent observer in
#' `.createObservers()` unless they are hidden by [hideInterface()] (see
#' section "Hiding interface elements" on this page).
#'
#' It is the developer's responsibility to call [callNextMethod()] to obtain
#' interface elements for parent classes.
#' A common strategy is to combine the output of [callNextMethod()] with
#' additional [iSEE::collapseBox()] elements to achieve the desired UI structure.
#' 
#' @return `defineInterface`: A list of [iSEE::collapseBox()]  elements.
#' See section "Defining the parameter interface" below for further details.
#' 
#' @examples 
#' showMethods("defineInterface")
#' 
#' @export
#' @describeIn interface-generics defines the UI for modifying all parameters
#' for a given panel.
setGeneric("defineInterface", function(x, se, select_info) standardGeneric("defineInterface"))

#' @section Defining the data parameter interface:
#' `defineDataInterface(x, se, select_info)` defines the UI for data-related
#' (i.e., non-aesthetic) parameters.
#' 
#' Methods for this generic are expected to return a list of UI elements for
#' altering data-related parameters,
#' which are automatically placed inside the \dQuote{Data parameters}
#' collapsible box.
#' Each element's ID should still follow the `PANEL_SLOT` pattern described above.
#'
#' This generic aims to provide a simpler alternative to specializing
#' `defineInterface()` for the most common use case.
#' New panels can write methods for this generic to add their own interface
#' elements for altering the contents of the panel, without needing to
#' reimplement other UI elements in the parent class's `defineInterface()`
#' method.
#' Conversely, there is no obligation to write a method for this generic if one
#' is planning to specialize `defineInterface()`.
#'
#' It is the developer's responsibility to call [callNextMethod()] to obtain
#' interface elements for parent classes.
#'
#' It is the developer's responsibility to call [callNextMethod()] to hide the
#' same interface elements as parent classes.
#' This is not strictly required if one wishes to expose previously hidden
#' elements.
#' 
#' @return `defineDataInterface`: a list of UI elements for altering
#' data-related parameters, which are automatically placed inside the
#' \dQuote{Data parameters} collapsible box.
#' See section "Defining the data parameter interface" below for further
#' details.
#' 
#' @examples
#' showMethods("defineDataInterface")
#' 
#' @export
#' @describeIn interface-generics defines the UI for data-related (i.e.,
#' non-aesthetic) parameters.
setGeneric("defineDataInterface", function(x, se, select_info) standardGeneric("defineDataInterface"))

#' @section Hiding interface elements:
#' `hideInterface(x, field)` determines whether certain UI elements should
#' be hidden from the user.
#'
#' Methods for this generic are expected to return a logical scalar indicating
#' whether the interface element corresponding to `field` should be hidden from
#' the user.
#' This is useful for hiding UI elements that cannot be changed or have no
#' effect, especially in highly specialized subclasses where some concepts in
#' the parent class may no longer be relevant.
#' (The alternative would be to reimplement all of the parent's
#' `defineInterface()` method just to omit a handful of UI elements!)
#' 
#' @return `hideInterface`: a logical scalar indicating whether the interface
#' element corresponding to field should be hidden from the user.
#' See section "Hiding interface elements" below for further details.
#' 
#' @examples 
#' showMethods("hideInterface")
#' 
#' @export
#' @describeIn interface-generics determines whether certain UI elements should be hidden from the user.
setGeneric("hideInterface", function(x, field) standardGeneric("hideInterface"))
