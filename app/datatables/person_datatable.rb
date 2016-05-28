class PersonDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Person.id Person.first_name Person.last_name Person.email Person.tags Person.created_at)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Person.first_name Person.last_name Person.email Person.tags Person.created_at)
  end

  private

  def data
    records.map do |record|
      [
        record.id,
        record.first_name,
        record.last_name,
        record.email,
        record.zip_code,
        record.donation_type,
        record.donation_status_with_button_for_datatable,
        record.donation_amount,
        record.created_at.strftime('%d/%m/%Y %H:%M'),
      ]
    end
  end

  def get_raw_records
    Person.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
