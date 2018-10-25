defmodule TdDf.Templates do
  @moduledoc """
  The Templates context.
  """

  import Ecto.Query, warn: false
  alias TdDf.Repo

  alias Ecto.Changeset
  alias TdDf.Templates.Template
  alias TdDf.TemplateLoader

  @string "string"
  @list "list"
  @variable_list "variable_list"
  @variable_map_list "variable_map_list"

  @doc """
  Returns the list of templates.

  ## Examples

      iex> list_templates()
      [%Template{}, ...]

  """
  def list_templates do
    Repo.all(Template)
  end

  def list_templates_by_id(id_list) do
    Template
    |> where([t], t.id in ^id_list)
    |> Repo.all
  end

  @doc """
  Gets a single template.

  Raises `Ecto.NoResultsError` if the Template does not exist.

  ## Examples

      iex> get_template!(123)
      %Template{}

      iex> get_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_template!(id), do: Repo.get!(Template, id)

  def get_template_by_name!(name) do
    Repo.one! from r in Template, where: r.name == ^name
  end

  def get_template_by_name(name) do
    Repo.one from r in Template, where: r.name == ^name
  end

  def get_default_template do
    Repo.one from r in Template, where: r.is_default == true, limit: 1
  end

  @doc """
  Creates a template.

  ## Examples

      iex> create_template(%{field: value})
      {:ok, %Template{}}

      iex> create_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_template(attrs \\ %{}) do
    %Template{}
    |> Template.changeset(attrs)
    |> Repo.insert()
    |> refresh_cache
  end

  @doc """
  Updates a template.

  ## Examples

      iex> update_template(template, %{field: new_value})
      {:ok, %Template{}}

      iex> update_template(template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_template(%Template{} = template, attrs) do
    template
    |> Template.changeset(attrs)
    |> Repo.update()
    |> refresh_cache
  end

  @doc """
  Deletes a Template.

  ## Examples

      iex> delete_template(template)
      {:ok, %Template{}}

      iex> delete_template(template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_template(%Template{} = template) do
    Repo.delete(template)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking template changes.

  ## Examples

      iex> change_template(template)
      %Ecto.Changeset{source: %Template{}}

  """
  def change_template(%Template{} = template) do
    Template.changeset(template, %{})
  end

  alias TdDf.Templates.TemplateRelation

  @doc """
  Returns the list of template_relations.

  ## Examples

      iex> list_template_relations()
      [%TemplateRelation{}, ...]

  """
  def list_template_relations do
    Repo.all(TemplateRelation)
  end

  def list_related_template_ids(resource_id, resource_type) do
    TemplateRelation
    |> where(resource_id: ^resource_id)
    |> where(resource_type: ^resource_type)
    |> Repo.all
  end

  @doc """
  Gets a single template_relation.

  Raises `Ecto.NoResultsError` if the Template relation does not exist.

  ## Examples

      iex> get_template_relation!(123)
      %TemplateRelation{}

      iex> get_template_relation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_template_relation!(id), do: Repo.get!(TemplateRelation, id)

  @doc """
  Creates a template_relation.

  ## Examples

      iex> create_template_relation(%{field: value})
      {:ok, %TemplateRelation{}}

      iex> create_template_relation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_template_relation(attrs \\ %{}) do
    %TemplateRelation{}
    |> TemplateRelation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a template_relation.

  ## Examples

      iex> update_template_relation(template_relation, %{field: new_value})
      {:ok, %TemplateRelation{}}

      iex> update_template_relation(template_relation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_template_relation(%TemplateRelation{} = template_relation, attrs) do
    template_relation
    |> TemplateRelation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TemplateRelation.

  ## Examples

      iex> delete_template_relation(template_relation)
      {:ok, %TemplateRelation{}}

      iex> delete_template_relation(template_relation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_template_relation(%TemplateRelation{} = template_relation) do
    Repo.delete(template_relation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking template_relation changes.

  ## Examples

      iex> change_template_relation(template_relation)
      %Ecto.Changeset{source: %TemplateRelation{}}

  """
  def change_template_relation(%TemplateRelation{} = template_relation) do
    TemplateRelation.changeset(template_relation, %{})
  end

  defp refresh_cache({:ok, %{name: name}} = response) do
    TemplateLoader.refresh(name)
    response
  end
  defp refresh_cache(response), do: response
end
