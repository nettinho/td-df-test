defmodule TdDfWeb.TemplateView do
  use TdDfWeb, :view
  alias TdDfWeb.TemplateView

  def render("index.json", %{templates: templates}) do
    %{data: render_many(templates, TemplateView, "template.json")}
  end

  def render("show.json", %{template: template}) do
    %{data: render_one(template, TemplateView, "template.json")}
  end

  def render("template.json", %{template: template}) do
    %{id: template.id,
      label: template.label,
      name: template.name,
      content: template.content,
      is_default: template.is_default
    }
  end

  def render("validations.json", %{validations: validations}) do
    %{data: validations}
  end
end
